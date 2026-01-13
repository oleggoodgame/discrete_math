import 'package:discrete_math/data/entity/vertex_entity.dart';

sealed class HamiltonianEvent {}

class HamiltonianStart extends HamiltonianEvent {
  final Set<Vertex> vertices;
  HamiltonianStart(this.vertices);
}