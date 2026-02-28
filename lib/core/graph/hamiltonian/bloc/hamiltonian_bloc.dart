import 'package:discrete_math/core/graph/hamiltonian/event/hamiltonian_event.dart';
import 'package:discrete_math/core/graph/hamiltonian/service/hamiltonian_service.dart';
import 'package:discrete_math/core/graph/hamiltonian/state/hamiltonian_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HamiltonianBloc extends Bloc<HamiltonianEvent, HamiltonianState> {
  final HamiltonianService service;

  HamiltonianBloc({required this.service}) : super(HamiltonianInitial()) {
    on<HamiltonianStart>((event, emit) async {
      emit(HamiltonianProcessing());

      final result = service.analyze(graph: event.graph);
      emit(HamiltonianResult(result));
    });
  }
}
