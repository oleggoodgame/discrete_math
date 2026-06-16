part of 'hamiltonian_bloc.dart';

sealed class HamiltonianState {}

class HamiltonianInitial extends HamiltonianState {}

class HamiltonianProcessing extends HamiltonianState {}

class HamiltonianResult extends HamiltonianState {
  final HamiltonianAnalysis analysis;
  HamiltonianResult(this.analysis);
}
