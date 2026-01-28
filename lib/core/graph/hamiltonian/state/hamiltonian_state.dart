import 'package:discrete_math/core/graph/hamiltonian/type/hamiltonian_type.dart';

sealed class HamiltonianState {}

class HamiltonianInitial extends HamiltonianState {}

class HamiltonianProcessing extends HamiltonianState {}

class HamiltonianResult extends HamiltonianState {
  final HamiltonianAnalysis analysis;
  HamiltonianResult(this.analysis);
}
