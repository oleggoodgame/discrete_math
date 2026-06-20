import 'package:discrete_math/core/favorite/presentation/provider/favorite_provider.dart';
import 'package:discrete_math/core/favorite/presentation/bloc/favorite_cubit.dart';
import 'package:discrete_math/core/graph/presentation/bloc/graph_bloc/graphs_bloc.dart';
import 'package:discrete_math/core/graph/presentation/widget/graph_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ListGraphsWidget extends ConsumerWidget {
  const ListGraphsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favorites = ref.watch(favoriteProviderProvider);
    // final favoriteNotifier = ref.watch(favoriteProviderProvider.notifier);

    return BlocListener<FavoriteCubit, FavoriteState>(
      listener: (context, state) {
        if (state is FavoriteLoaded) {
          ref.read(favoriteProviderProvider.notifier).setAll(state.ids);
        }
      },
      child: BlocBuilder<GraphsCubit, GraphsState>(
        builder: (context, state) {
          return BlocBuilder<FavoriteCubit, FavoriteState>(
            builder: (fav_context, fav_state) {
              if (fav_state is FavoriteError) {
                print(fav_state.message);
                return Center(child: Text(fav_state.message));
              }
              if (state is GraphsLoading) {
                print("Loading");

                return const Center(child: CircularProgressIndicator());
              }
              if (state is GraphsError) {
                print(state.message);
                return Center(child: Text(state.message));
              }
              if (state is GraphsLoaded) {
                print("LOADED");
                // print(state.graphs.length);
                // print(state.graphs.first);
                if (state.graphs.isNotEmpty) {
                  return ListView.builder(
                    itemCount: state.graphs.length,
                    itemBuilder: (context, index) {
                      final graph = state.graphs[index];

                      final isFavorite = favorites.any((id) => id == graph.id);

                      return GraphWidget(isFavorite: isFavorite, graph: graph);
                    },
                  );
                } else {
                  return Center(
                    child: Text(
                      "There is no graphs",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  );
                }
              }

              return Center(
                child: Text(
                  "There is no graphs",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
