part of 'hamiltonian_bloc.dart';


sealed class HamiltonianEvent {}

class HamiltonianStart extends HamiltonianEvent {
  final Map<String, Vertex> graph;
  HamiltonianStart(this.graph);
}
