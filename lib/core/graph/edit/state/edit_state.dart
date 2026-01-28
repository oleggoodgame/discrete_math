import 'package:discrete_math/application/data/entity/graph/graph_entity.dart';

sealed class EditState {}

class EditInitial extends EditState {}

class EditProcessing extends EditState {}

class EditSuccess extends EditState {
  final GraphEntity graph;
  EditSuccess(this.graph);
}

class EditError extends EditState {
  final String message;
  EditError(this.message);
}
