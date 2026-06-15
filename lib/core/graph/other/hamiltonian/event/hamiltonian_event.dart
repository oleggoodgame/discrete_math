import 'package:discrete_math/core/graph/domain/entity/vertex_entity.dart';

sealed class HamiltonianEvent {}

class HamiltonianStart extends HamiltonianEvent {
  final Map<String, Vertex> graph;
  HamiltonianStart(this.graph);
}
