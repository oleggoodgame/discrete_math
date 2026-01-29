import 'package:discrete_math/application/data/entity/vertex_entity.dart';
import 'package:discrete_math/application/data/style/theme_style.dart';
import 'package:discrete_math/core/graph/edit/bloc/edit_bloc.dart';
import 'package:discrete_math/core/graph/graphs/bloc/graphs_bloc.dart';
import 'package:discrete_math/presentation/widget/list_graphs_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

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
              final title = await _showTitleDialog(context, {});

              if (title == null) return;
              await context.read<EditCubit>().createGraph(
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

  Future<String?> _showTitleDialog(
    BuildContext context,
    Set<Vertex> vertices,
  ) async {
    final formKey = GlobalKey<FormState>();
    final titleController = TextEditingController();

    final result = await showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Graph title',
                    style: Theme.of(context).textTheme.titleMedium,
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: sLarge),

                  TextFormField(
                    controller: titleController,
                    decoration: const InputDecoration(
                      labelText: 'Title',
                      hintText: 'e.g. My graph',
                    ),
                    validator: (v) {
                      if (v == null || v.trim().isEmpty) {
                        return 'Please enter title';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: sLarge),

                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.pop(dialogContext, null);
                          },
                          child: const Text('Cancel'),
                        ),
                      ),

                      const SizedBox(width: sMedium),

                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            if (!formKey.currentState!.validate()) return;

                            Navigator.pop(
                              dialogContext,
                              titleController.text.trim(),
                            );
                          },
                          child: const Text('OK'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );

    titleController.dispose();
    return result;
  }
}
