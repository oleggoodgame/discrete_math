import 'package:discrete_math/application/data/entity/graph/graph_entity.dart';
import 'package:discrete_math/application/provider/favorite_provider.dart';
import 'package:discrete_math/core/graph/favorite/cubit/favorite_cubit.dart';
import 'package:discrete_math/core/graph/favorite/state/favorite_state.dart';
import 'package:discrete_math/core/graph/graphs/bloc/graphs_bloc.dart';
import 'package:discrete_math/core/graph/graphs/state/graphs_state.dart';
import 'package:discrete_math/presentation/widget/graph_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoriteScreen extends ConsumerStatefulWidget {
  const FavoriteScreen({super.key});

  @override
  ConsumerState<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends ConsumerState<FavoriteScreen> {
  Set<String> _favoriteIds = {};
  List<GraphEntity> _allGraphs = [];
  List<GraphEntity> _favoriteGraphs = [];

  bool _favoritesLoaded = false;
  bool _graphsLoaded = false;

  @override
  void initState() {
    super.initState();

    print('🚀 FavoriteScreen initState');

    context.read<FavoriteCubit>().load();

    final graphsState = context.read<GraphsCubit>().state;
    print('📦 GraphsCubit initial state = $graphsState');

    if (graphsState is GraphsLoaded) {
      print('✅ Graphs already loaded in initState');
      _allGraphs = graphsState.graphs;
      _graphsLoaded = true;
    } else {
      print('⏳ Graphs NOT loaded yet');
    }
  }

  void _tryBuildFavorites() {
    if (!_favoritesLoaded || !_graphsLoaded) return;

    final ids = _favoriteIds;

    _favoriteGraphs = _allGraphs.where((g) => ids.contains(g.id)).toList();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<FavoriteCubit, FavoriteState>(
          listener: (context, state) {
            print('⭐ FavoriteCubit state: $state');

            if (state is FavoriteLoaded) {
              print('✅ FavoriteLoaded ids=${state.ids.length}');
              _favoriteIds = state.ids;
              _favoritesLoaded = true;

              ref.read(favoriteProviderProvider.notifier).setAll(state.ids);

              _tryBuildFavorites();
            }
          },
        ),
        BlocListener<GraphsCubit, GraphsState>(
          listener: (context, state) {
            print('📊 GraphsCubit state: $state');

            if (state is GraphsLoaded) {
              print('✅ GraphsLoaded graphs=${state.graphs.length}');
              _allGraphs = state.graphs;
              _graphsLoaded = true;

              _tryBuildFavorites();
            }
          },
        ),
      ],
      child: Scaffold(
        appBar: AppBar(title: const Text("Favorites")),
        body: (_favoritesLoaded && _graphsLoaded)
            ? _favoriteGraphs.isEmpty
                  ? const Center(child: Text("No favorites yet"))
                  : ListView.builder(
                      itemCount: _favoriteGraphs.length,
                      itemBuilder: (context, index) {
                        final graph = _favoriteGraphs[index];
                        return GraphWidget(isFavorite: true, graph: graph);
                      },
                    )
            : const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
