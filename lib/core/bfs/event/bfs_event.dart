import 'package:discrete_math/data/entity/vertex_entity.dart';

sealed class GraphEvent {}

class StartBfs extends GraphEvent {
  final Vertex start;
  final Map<String, Vertex> graph;

  StartBfs({required this.start, required this.graph});
}
