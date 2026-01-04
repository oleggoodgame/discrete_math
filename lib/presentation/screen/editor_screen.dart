import 'package:discrete_math/application/provider/fab_provider.dart';
import 'package:discrete_math/application/provider/selected_vertexes_provider.dart';
import 'package:discrete_math/application/provider/graph_provider.dart';
import 'package:discrete_math/core/bfs/bloc/bloc_bfs.dart';
import 'package:discrete_math/core/bfs/event/bfs_event.dart';
import 'package:discrete_math/core/bfs/state/bfs_state.dart';
import 'package:discrete_math/presentation/painter/graph_painer.dart';
import 'package:discrete_math/presentation/widget/treeVertex_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class EditorScreen extends ConsumerStatefulWidget {
  const EditorScreen({super.key});

  @override
  ConsumerState<EditorScreen> createState() => _EditorScreenState();
}

const double canvasSize = 3000;
const double vertexRadius = 25;

class _EditorScreenState extends ConsumerState<EditorScreen> {
  final TransformationController _controller =
      TransformationController(); // мозок

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
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final vertices = ref.watch(graphProviderProvider);
    final selectedVertex = ref.watch(selectedVertexProvider);
    final isFabOpen = ref.watch(fabMenuOpenProvider);
    final bloc = ref.read(graphBlocProvider);
    return BlocListener<GraphBloc, GraphState>(
      bloc: bloc,
      listener: (context, state) {
        if (state is GraphResult) {
          ref.read(graphProviderProvider.notifier).setVertices(state.visited);
        }
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Editor Screen')),
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
                    color: Colors.white,
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
                bottom: 90,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    _FabMenuItem(
                      icon: Icons.timeline,
                      label: 'Обхід',
                      onTap: () {},
                    ),
                    _FabMenuItem(
                      icon: Icons.account_tree,
                      label: 'DFS',
                      onTap: () {},
                    ),
                    _FabMenuItem(
                      icon: Icons.swap_horiz,
                      label: 'BFS',
                      onTap: () {
                        final graphMap = {for (final v in vertices) v.data: v};

                        bloc.add(
                          StartBfs(start: vertices.first, graph: graphMap),
                        );
                      },
                    ),
                    _FabMenuItem(
                      icon: Icons.info_outline,
                      label: 'Information',
                      onTap: () {},
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
                  _ZoomButton(icon: Icons.remove, onPressed: () => _zoom(-0.2)),
                ],
              ),
            ),
          ],
        ),
      ),
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
