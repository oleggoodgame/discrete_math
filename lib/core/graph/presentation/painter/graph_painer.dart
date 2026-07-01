import 'package:discrete_math/core/graph/domain/entity/vertex_entity.dart';
import 'package:flutter/material.dart';

// class GraphPainter extends CustomPainter {
//   final Set<Vertex> vertices;

//   GraphPainter({required this.vertices});

//   @override
//   void paint(Canvas canvas, Size size) {
//     _drawEdges(canvas);
//     // _drawVertices(canvas);
//   }

//   void _drawEdges(Canvas canvas) {
//     for (final vertex in vertices) {
//       if (vertex.connection.isEmpty)
//         continue;
//       else {
//         // final fromId = vertex.offset;
//         for (final connectionId in vertex.connection) {
//           final toVertex = vertices.cast<Vertex?>().firstWhere(
//             (v) => v?.data == connectionId,
//             orElse: () => null,
//           );

//           if (toVertex == null) continue;

//           canvas.drawLine(
//             vertex.offset,
//             toVertex.offset,
//             Paint()
//               ..color = _edgeColor(vertex.state, toVertex.state)
//               ..strokeWidth = 2
//               ..style = PaintingStyle.stroke,
//           );
//         }
//       }
//     }
//   }

//   @override
//   bool shouldRepaint(covariant GraphPainter oldDelegate) {
//     return oldDelegate.vertices != vertices;
//   }
// }

class GraphPainter extends CustomPainter {
  final Set<Vertex> vertices;
  late final Map<String, Vertex> _vertexMap; // кешований Map

  GraphPainter({required this.vertices}) {
    _vertexMap = {for (final v in vertices) v.data: v}; // O(n) один раз
  }

  void _drawEdges(Canvas canvas) {
    final drawnEdges = <String>{}; // відстежуємо вже намальовані ребра

    for (final vertex in vertices) {
      for (final connectionId in vertex.connection) {
        // створюємо унікальний ключ для пари вершин
        final edgeKey = [vertex.data, connectionId]..sort();
        final key = edgeKey.join('-');

        if (drawnEdges.contains(key)) continue; // вже намалювали
        drawnEdges.add(key);

        final toVertex = _vertexMap[connectionId];
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

  @override
  bool shouldRepaint(covariant GraphPainter oldDelegate) {
    if (oldDelegate.vertices.length != vertices.length) return true;

    // порівнюємо offset кожної вершини — це найважливіше для перемальовування
    final oldList = oldDelegate.vertices.toList();
    final newList = vertices.toList();
    for (int i = 0; i < oldList.length; i++) {
      if (oldList[i].offset != newList[i].offset) return true;
      if (oldList[i].state != newList[i].state) return true;
    }
    return false;
  }

  Color _edgeColor(VertexState state1, VertexState state2) {
    if (state1 == state2 && state1 == VertexState.idle) return Colors.black;
    if (state1 == VertexState.visiting || state2 == VertexState.visiting)
      return Colors.orange;
    if (state1 == state2 && state1 == VertexState.visited) return Colors.green;
    return Colors.black;
  }

  @override
  void paint(Canvas canvas, Size size) {
    _drawEdges(canvas);
    // _drawVertices(canvas);
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
