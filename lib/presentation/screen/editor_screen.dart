import 'package:discrete_math/application/provider/treeVertex_provider.dart';
import 'package:discrete_math/presentation/painter/graph_painer.dart';
import 'package:discrete_math/presentation/widget/treeEdge_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class EditorScreen extends ConsumerStatefulWidget {
  const EditorScreen({super.key});

  @override
  ConsumerState<EditorScreen> createState() => _EditorScreenState();
}

class _EditorScreenState extends ConsumerState<EditorScreen> {
  @override
  Widget build(BuildContext context) {
    final vertices = ref.watch(treeVertexProviderProvider);
    // final edges = ref.watch(treeEdgeProviderProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Editor Screen')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push('/addVertex');
        },
        child: const Icon(Icons.add, color: Colors.black),
        backgroundColor: Colors.blueGrey,
      ),
      body: Stack(
        children: [
          CustomPaint(
            size: Size.infinite,
            painter: GraphPainter(vertices: vertices),
          ),
          for (final vertex in vertices)
            Positioned(
              left: vertex.offset.dx - 25,
              top: vertex.offset.dy - 25,
              child: TreeVertexWidget(treeVertex: vertex,),
            ),
        ],
      ),
    );
  }
}
