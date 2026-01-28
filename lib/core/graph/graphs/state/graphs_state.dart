import 'package:discrete_math/application/data/entity/graph/graph_entity.dart';

abstract class GraphsState {}

class GraphsInitial extends GraphsState {}

class GraphsLoading extends GraphsState {}

class GraphsLoaded extends GraphsState {
  final List<GraphEntity> graphs;
  GraphsLoaded(this.graphs);
}

class GraphsError extends GraphsState {
  final String message;
  GraphsError(this.message);
}
