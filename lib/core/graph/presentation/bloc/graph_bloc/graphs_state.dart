
part of 'graphs_bloc.dart';
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
