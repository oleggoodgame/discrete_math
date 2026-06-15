
import 'package:discrete_math/core/graph/domain/entity/vertex_entity.dart';

sealed class GraphEvent {}

class StartGraph extends GraphEvent {
  final Vertex start;
  final Map<String, Vertex> graph;

  StartGraph({required this.start, required this.graph});
}
