import 'package:discrete_math/core/graph/domain/entity/graph_entity.dart';
import 'package:discrete_math/shared/theme/style/theme_style.dart';
import 'package:discrete_math/core/graph/presentation/bloc/bfs_dfs_bloc/graph_event.dart';
import 'package:discrete_math/core/graph/presentation/bloc/bfs_dfs_bloc/graph_state.dart';
import 'package:discrete_math/core/graph/presentation/provider/fab_provider.dart';
import 'package:discrete_math/core/graph/presentation/provider/selected_vertexes_provider.dart';
import 'package:discrete_math/core/graph/presentation/provider/graph_provider.dart';
import 'package:discrete_math/core/graph/presentation/bloc/bfs_dfs_bloc/bloc_bfs.dart';
import 'package:discrete_math/core/graph/presentation/bloc/detoure_bloc/detour_bloc.dart';
import 'package:discrete_math/core/graph/presentation/bloc/bfs_dfs_bloc/bloc_dfs.dart';
import 'package:discrete_math/core/graph/domain/entity/vertex_entity.dart';
import 'package:discrete_math/core/graph/presentation/bloc/edit_bloc/edit_bloc.dart';
import 'package:discrete_math/core/graph/presentation/bloc/graph_bloc/graphs_bloc.dart';
import 'package:discrete_math/core/graph/presentation/painter/graph_painer.dart';
import 'package:discrete_math/shared/widgets/text_controller_widget.dart';
import 'package:discrete_math/shared/widgets/treeVertex_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class EditorScreen extends ConsumerStatefulWidget {
  const EditorScreen({required this.graph, super.key});
  final GraphEntity graph;
  @override
  ConsumerState<EditorScreen> createState() => _EditorScreenState();
}

const double canvasSize = 3000;
const double vertexRadius = 25;

class _EditorScreenState extends ConsumerState<EditorScreen> {
  final TransformationController _controller =
      TransformationController(); 

  void _zoom(double delta) {
    final scale = (_controller.value.getMaxScaleOnAxis() + delta).clamp(
      0.5,
      3.0,
    );
    //Це 4×4 матриця трансформацій
    //     Що це?

    // Це метод Matrix4, який:

    // дивиться на матрицю

    // дістає поточний scale

    // по найбільшій осі (X або Y)

    // 📌 Чому не зберігати _currentScale?
    // Бо:

    // користувач може зумити пальцями

    // scale зміниться без твого коду

    // _controller — єдине джерело правди
    final matrix = Matrix4.identity()
      ..translate(
        MediaQuery.of(context).size.width / 2,
        MediaQuery.of(context).size.height / 2,
      )
      ..scale(scale)
      ..translate(
        -MediaQuery.of(context).size.width / 2,
        -MediaQuery.of(context).size.height / 2,
      );

    _controller.value = matrix;
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(graphProviderProvider.notifier).setVertices(widget.graph.data);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  // return BlocListener<GraphBloc, GraphState>(
  //   bloc: bloc,
  //   listener: (context, state) {
  //     if (state is GraphResult) {
  //       ref.read(graphProviderProvider.notifier).setVertices(state.visited);
  //     }
  //   },

  @override
  Widget build(BuildContext context) {
    final vertices = ref.watch(graphProviderProvider);
    final selectedVertex = ref.watch(selectedVertexProvider);
    final isFabOpen = ref.watch(fabMenuOpenProvider);
    final fifi = Theme.of(context).brightness == Brightness.light;
    final notifier = ref.read(graphProviderProvider.notifier);

    return MultiBlocListener(
      listeners: [
        BlocListener<DetourBloc, DetourState>(
          listener: (context, state) {
            if (state is DetourResult) {
              ref
                  .read(graphProviderProvider.notifier)
                  .setVertices(state.visited);
            }
            if (state is DetourError) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.error)));
            }
          },
        ),
        BlocListener<BfsBloc, GraphState>(
          listener: (context, state) {
            if (state is GraphResult) {
              ref
                  .read(graphProviderProvider.notifier)
                  .setVertices(state.visited);
            }
          },
        ),
        BlocListener<DfsBloc, GraphState>(
          listener: (context, state) {
            if (state is GraphResult) {
              ref
                  .read(graphProviderProvider.notifier)
                  .setVertices(state.visited);
            }
          },
        ),
      ],
      child: PopScope(
        onPopInvokedWithResult: (didPop, result) {
          if (notifier.isAlgorithmRunning) {
            notifier.restoreSnapshot();
          }

          context.read<EditCubit>().editGraph(
            data: ref.read(graphProviderProvider),
            id: widget.graph.id,
          );
          context.read<GraphsCubit>().loadGraphs();
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Editor Screen'),
            actions: [
              IconButton(
                onPressed: () {
                  context.read<EditCubit>().editGraph(
                    data: ref.read(graphProviderProvider),
                    id: widget.graph.id,
                  );
                },
                icon: Icon(Icons.save),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.blueGrey,
            onPressed: () {
              ref.read(fabMenuOpenProvider.notifier).state = !isFabOpen;
            },
            child: Icon(
              isFabOpen ? Icons.close : Icons.menu,
              color: Colors.black,
            ),
          ),
          body: Stack(
            children: [
              InteractiveViewer(
                transformationController: _controller,
                minScale: 0.5,
                maxScale: 3.0,
                boundaryMargin: const EdgeInsets.all(0),
                constrained: false,
                child: Center(
                  child: Container(
                    width: canvasSize,
                    height: canvasSize,
                    decoration: BoxDecoration(
                      color: fifi ? Colors.white : Colors.grey.shade400,
                      border: Border.all(color: Colors.black, width: 3),
                    ),
                    child: Stack(
                      children: [
                        CustomPaint(
                          size: const Size(canvasSize, canvasSize),
                          painter: GraphPainter(vertices: vertices),
                        ),

                        for (final vertex in vertices)
                          Positioned(
                            left: vertex.offset.dx - 25,
                            top: vertex.offset.dy - 25,
                            child: TreeVertexWidget(vertex: vertex),
                          ),

                        if (selectedVertex != null)
                          Positioned(
                            left: selectedVertex.offset.dx + 30,
                            top: selectedVertex.offset.dy - 20,
                            child: VertexContextMenu(vertex: selectedVertex),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
              if (isFabOpen)
                Positioned(
                  right: 16,
                  bottom: 88,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      _FabMenuItem(
                        icon: Icons.timeline,
                        label: 'Path',
                        onTap: () {
                          final vertices = ref.read(graphProviderProvider);
                          ref
                              .read(graphProviderProvider.notifier)
                              .takeSnapshot();

                          _showDetourDialog(context, vertices);
                        },
                      ),
                      _FabMenuItem(
                        icon: Icons.account_tree,
                        label: 'DFS',
                        onTap: () {
                          final vertices = ref.read(graphProviderProvider);
                          final graphMap = {
                            for (final v in vertices) v.data: v,
                          };
                          ref
                              .read(graphProviderProvider.notifier)
                              .takeSnapshot();

                          context.read<DfsBloc>().add(
                            StartGraph(start: vertices.first, graph: graphMap),
                          );
                        },
                      ),
                      _FabMenuItem(
                        icon: Icons.swap_horiz,
                        label: 'BFS',
                        onTap: () {
                          final vertices = ref.read(graphProviderProvider);
                          final graphMap = {
                            for (final v in vertices) v.data: v,
                          };
                          ref
                              .read(graphProviderProvider.notifier)
                              .takeSnapshot();

                          context.read<BfsBloc>().add(
                            StartGraph(start: vertices.first, graph: graphMap),
                          );
                        },
                      ),
                      _FabMenuItem(
                        icon: Icons.info_outline,
                        label: 'Information',
                        onTap: () => context.push(
                          '/information_screen',
                          extra: widget.graph,
                        ),
                      ),
                      _FabMenuItem(
                        icon: Icons.add_circle_outline,
                        label: 'Add',
                        onTap: () => context.push('/add_vertex'),
                      ),
                      const SizedBox(height: 6),
                    ],
                  ),
                ),
              Positioned(
                left: 16,
                bottom: 16,
                child: Column(
                  children: [
                    _ZoomButton(icon: Icons.add, onPressed: () => _zoom(0.2)),
                    const SizedBox(height: 8),
                    _ZoomButton(
                      icon: Icons.remove,
                      onPressed: () => _zoom(-0.2),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showDetourDialog(BuildContext context, Set<Vertex> vertices) {
    final startController = TextEditingController();
    final findController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    final detourBloc = context.read<DetourBloc>();
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
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
                    'Path between vertices',
                    style: Theme.of(context).textTheme.titleMedium,
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: sLarge),
                  TextControllerWidget(
                    controller: startController,
                    label: 'Start vertex',
                    hint: 'e.g. A',
                    validator: (v) {
                      if (v == null || v.isEmpty) {
                        return 'Please enter start vertex';
                      }

                      final exists = vertices.any((e) => e.data == v);
                      if (!exists) {
                        return 'Vertex "$v" does not exist';
                      }

                      return null;
                    },
                  ),

                  const SizedBox(height: sMedium),
                  TextControllerWidget(
                    controller: findController,
                    label: 'Find vertex',
                    hint: 'e.g. D',
                    validator: (v) {
                      if (v == null || v.isEmpty) {
                        return 'Please enter find vertex';
                      }

                      final exists = vertices.any((e) => e.data == v);
                      if (!exists) {
                        return 'Vertex "$v" does not exist';
                      }

                      return null;
                    },
                  ),

                  const SizedBox(height: sLarge),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Cancel'),
                        ),
                      ),
                      const SizedBox(width: sMedium),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            if (!formKey.currentState!.validate()) return;

                            final startId = startController.text.trim();
                            final findId = findController.text.trim();

                            final startVertex = vertices.firstWhere(
                              (v) => v.data == startId,
                            );
                            final findVertex = vertices.firstWhere(
                              (v) => v.data == findId,
                            );

                            final graphMap = {
                              for (final v in vertices) v.data: v,
                            };

                            detourBloc.add(
                              //
                              StartDetour(
                                start: startVertex,
                                find: findVertex,
                                graph: graphMap,
                              ),
                            );

                            Navigator.pop(context);
                          },
                          child: const Text('Start'),
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
  }
}

class _FabMenuItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _FabMenuItem({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Material(
        color: Colors.blueGrey,
        borderRadius: BorderRadius.circular(12),
        elevation: 4,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, color: Colors.black),
                const SizedBox(width: 8),
                Text(label, style: const TextStyle(color: Colors.black)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ZoomButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const _ZoomButton({required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.blueGrey,
      borderRadius: BorderRadius.circular(12),
      elevation: 4,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onPressed,
        child: SizedBox(
          width: 44,
          height: 44,
          child: Icon(icon, color: Colors.black),
        ),
      ),
    );
  }
}
