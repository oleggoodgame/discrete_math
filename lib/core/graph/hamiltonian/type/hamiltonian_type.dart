import 'package:discrete_math/application/data/entity/vertex_entity.dart';

enum HamiltonianType {
  none,
  path,
  cycle,
}

class HamiltonianAnalysis {
  final HamiltonianType type;
  final Vertex? startVertex;
  final String explanation;

  HamiltonianAnalysis({
    required this.type,
    this.startVertex,
    required this.explanation,
  });
}