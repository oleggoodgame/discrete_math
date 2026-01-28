import 'package:discrete_math/application/data/entity/vertex_entity.dart';
import 'package:discrete_math/core/graph/edit/bloc/edit_bloc.dart';
import 'package:discrete_math/core/graph/graphs/bloc/graphs_bloc.dart';
import 'package:discrete_math/presentation/widget/list_graphs_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GraphsScreen extends StatefulWidget {
  const GraphsScreen({super.key});

  @override
  State<GraphsScreen> createState() => _GraphsScreenState();
}

class _GraphsScreenState extends State<GraphsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<GraphsCubit>().loadGraphs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Graphs"),
        actions: [
          IconButton.outlined(
            icon: const Icon(Icons.add_box_outlined),
            onPressed: () async {
              context.read<EditCubit>().createGraph(
                title: "Aboba",
                data: {
                  Vertex(
                    data: 'A',
                    offset: const Offset(100, 100),
                    connection: {'B', 'C'},
                  ),
                  Vertex(
                    data: 'B',
                    offset: const Offset(200, 200),
                    connection: {'A'},
                  ),
                  Vertex(
                    data: 'C',
                    offset: const Offset(300, 100),
                    connection: {'A'},
                  ),
                },
              );

              context.read<GraphsCubit>().loadGraphs();
            },
          ),
        ],
      ),
      body: const ListGraphsWidget(),
    );
  }
}
