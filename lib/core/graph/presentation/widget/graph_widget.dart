import 'package:discrete_math/core/graph/domain/entity/graph_entity.dart';
import 'package:discrete_math/core/favorite/presentation/provider/favorite_provider.dart';
import 'package:discrete_math/core/graph/presentation/provider/graph_provider.dart';
import 'package:discrete_math/core/favorite/presentation/bloc/favorite_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class GraphWidget extends ConsumerWidget {
  const GraphWidget({required this.isFavorite, required this.graph, super.key});
  final GraphEntity graph;
  final bool isFavorite;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          ref.read(graphProviderProvider.notifier).setVertices(graph.data);
          context.push('/editor', extra: graph);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(
              graph.title,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            subtitle: Text(
              graph.createdAt.toLocal().toString().substring(0, 16),
            ),
            trailing: IconButton(
              icon: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: isFavorite ? Colors.red : null,
              ),
              onPressed: () {
                ref.read(favoriteProviderProvider.notifier).toggle(graph);

                context.read<FavoriteCubit>().toggle(graph).catchError((_) {
                  ref.read(favoriteProviderProvider.notifier).toggle(graph);
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
