import 'package:discrete_math/application/data/entity/vertex_entity.dart';

sealed class GraphState {}

class GraphInitial extends GraphState {}

class GraphProcessing extends GraphState {}

class GraphResult extends GraphState {
  final Set<Vertex> visited;
  GraphResult(this.visited);
}
