import 'package:discrete_math/core/graph/domain/entity/vertex_entity.dart';

sealed class EulerianEvent {}

class EulerianStart extends EulerianEvent {
  final Set<Vertex> vertices;
  EulerianStart(this.vertices);
}