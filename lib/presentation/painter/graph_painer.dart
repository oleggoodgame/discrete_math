import 'package:discrete_math/data/entity/treeEdge_entity.dart';
import 'package:discrete_math/data/entity/treeVertex_entity.dart';
import 'package:flutter/material.dart';

class GraphPainter extends CustomPainter {
  final List<TreeVertex> vertices;

  GraphPainter({required this.vertices});

  @override
  void paint(Canvas canvas, Size size) {
    _drawEdges(canvas);
    // _drawVertices(canvas);
  }

  // =========================
  // 🔹 EDGES
  // =========================
  void _drawEdges(Canvas canvas) {
    for (final vertex in vertices) {
      if (vertex.connection.isEmpty)
        continue;
      else {
        final fromId = vertex.offset;
        for (final connectionId in vertex.connection) {
          final toId = vertices.where((v) => v.id == connectionId).single.offset;
          final paint = Paint()
            ..color = Colors.black
            ..strokeWidth = 2
            ..style = PaintingStyle.stroke;
          canvas.drawLine(fromId, toId, paint);
        }
      }
    }
  }

  // =========================
  // 🔹 VERTICES
  // =========================
  void _drawVertices(Canvas canvas) {
    for (final vertex in vertices) {
      final paint = Paint()
        ..color = Colors.blue
        ..style = PaintingStyle.fill;

      // коло
      canvas.drawCircle(vertex.offset, 22, paint);

      // текст усередині
      final textPainter = TextPainter(
        text: TextSpan(
          text: vertex.data,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
      )..layout();

      final textOffset =
          vertex.offset - Offset(textPainter.width / 2, textPainter.height / 2);

      textPainter.paint(canvas, textOffset);
    }
  }

  // =========================
  // 🔹 HELPERS
  // =========================
  Color _edgeColor(NodeState state) {
    switch (state) {
      case NodeState.visiting:
        return Colors.orange;
      case NodeState.visited:
        return Colors.green;
      case NodeState.idle:
        return Colors.black;
    }
  }

  @override
  bool shouldRepaint(covariant GraphPainter oldDelegate) {
    return oldDelegate.vertices != vertices;
  }
}
