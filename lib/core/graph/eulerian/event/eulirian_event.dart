import 'package:discrete_math/application/data/entity/vertex_entity.dart';

sealed class EulerianEvent {}

class EulerianStart extends EulerianEvent {
  final Set<Vertex> vertices;
  EulerianStart(this.vertices);
}