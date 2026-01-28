import 'package:discrete_math/application/data/entity/vertex_entity.dart';
import 'package:flutter/material.dart';

class GraphPainter extends CustomPainter {
  final Set<Vertex> vertices;

  GraphPainter({required this.vertices});

  @override
  void paint(Canvas canvas, Size size) {
    _drawEdges(canvas);
    // _drawVertices(canvas);
  }

  void _drawEdges(Canvas canvas) {
    for (final vertex in vertices) {
      if (vertex.connection.isEmpty)
        continue;
      else {
        // final fromId = vertex.offset;
        for (final connectionId in vertex.connection) {
          final toVertex = vertices.cast<Vertex?>().firstWhere(
            (v) => v?.data == connectionId,
            orElse: () => null,
          );

          if (toVertex == null) continue;

          canvas.drawLine(
            vertex.offset,
            toVertex.offset,
            Paint()
              ..color = _edgeColor(vertex.state, toVertex.state)
              ..strokeWidth = 2
              ..style = PaintingStyle.stroke,
          );
        }
      }
    }
  }

  // void _drawVertices(Canvas canvas) {
  //   for (final vertex in vertices) {
  //     final paint = Paint()
  //       ..color = Colors.blue
  //       ..style = PaintingStyle.fill;

  //     // коло
  //     canvas.drawCircle(vertex.offset, 22, paint);

  //     // текст усередині
  //     final textPainter = TextPainter(
  //       text: TextSpan(
  //         text: vertex.data,
  //         style: const TextStyle(
  //           color: Colors.white,
  //           fontSize: 12,
  //           fontWeight: FontWeight.bold,
  //         ),
  //       ),
  //       textAlign: TextAlign.center,
  //       textDirection: TextDirection.ltr,
  //     )..layout();

  //     final textOffset =
  //         vertex.offset - Offset(textPainter.width / 2, textPainter.height / 2);

  //     textPainter.paint(canvas, textOffset);
  //   }
  // }

  Color _edgeColor(VertexState state1, VertexState state2) {
    if (state1 == state2 && state1 == VertexState.idle) return Colors.black;
    if (state1 == state2 && state1 == VertexState.visiting)
      return Colors.orange;
    if (state1 == state2 && state1 == VertexState.visited) return Colors.green;
    return Colors.black;
  }

  @override
  bool shouldRepaint(covariant GraphPainter oldDelegate) {
    return oldDelegate.vertices != vertices;
  }
}
