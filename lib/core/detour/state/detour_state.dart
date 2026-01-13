import 'package:discrete_math/data/entity/vertex_entity.dart';

sealed class DetourState {}

class DetourInitial extends DetourState {}

class DetourProcessing extends DetourState {}

class DetourResult extends DetourState {
  final Set<Vertex> visited;
  DetourResult(this.visited);
}
