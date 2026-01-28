import 'package:discrete_math/application/provider/graph_provider.dart';
import 'package:discrete_math/core/graph/graphs/bloc/graphs_bloc.dart';
import 'package:discrete_math/core/graph/graphs/state/graphs_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ListGraphsWidget extends ConsumerWidget {
  const ListGraphsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BlocBuilder<GraphsCubit, GraphsState>(
      builder: (context, state) {
        if (state is GraphsLoading) {
          print("Loading");

          return const Center(child: CircularProgressIndicator());
        }
        if (state is GraphsError) {
          print(state.message);
          return const Center(child: Text("ERROR"));
        }
        if (state is GraphsLoaded) {
          print("LOADED");
          // print(state.graphs.length);
          // print(state.graphs.first);
          return ListView.builder(
            itemCount: state.graphs.length,
            itemBuilder: (context, index) {
              final graph = state.graphs[index];
              print("BUIDED");
              return GestureDetector(
                onTap: () {
                  ref
                      .watch(graphProviderProvider.notifier)
                      .setVertices(graph.data);
                  context.push('/editor', extra: graph);
                },
                child: ListTile(
                  title: Text(graph.title),
                  subtitle: Text(graph.createdAt.toLocal().toString()),
                ),
              );
            },
          );
        }

        return const Center(child: Text("There is no graphs"));
      },
    );
  }
}
