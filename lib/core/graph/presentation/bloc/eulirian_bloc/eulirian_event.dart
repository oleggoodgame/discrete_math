
part of'eulirian_bloc.dart';

sealed class EulerianEvent {}

class EulerianStart extends EulerianEvent {
  final Set<Vertex> vertices;
  EulerianStart(this.vertices);
}