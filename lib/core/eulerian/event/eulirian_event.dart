import 'package:discrete_math/data/entity/vertex_entity.dart';

sealed class EulerianEvent {}

class EulerianStart extends EulerianEvent {
  final Set<Vertex> vertices;
  EulerianStart(this.vertices);
}