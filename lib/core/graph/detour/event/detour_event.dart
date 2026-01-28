import 'package:discrete_math/application/data/entity/vertex_entity.dart';

sealed class DetourEvent {}

class StartDetour extends DetourEvent {
  final Vertex start;
  final Vertex find;
  final Map<String, Vertex> graph;

  StartDetour({required this.start, required this.find, required this.graph});
}
