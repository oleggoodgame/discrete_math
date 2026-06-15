import 'package:discrete_math/core/graph/domain/entity/vertex_entity.dart';

sealed class DetourState {}

class DetourInitial extends DetourState {}

class DetourProcessing extends DetourState {}

class DetourResult extends DetourState {
  final Set<Vertex> visited;
  DetourResult(this.visited);
}

class DetourError extends DetourState {
  final String error;
  DetourError(this.error);
}
