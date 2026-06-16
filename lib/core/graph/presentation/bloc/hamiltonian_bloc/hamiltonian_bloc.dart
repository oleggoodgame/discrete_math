import 'package:discrete_math/core/graph/domain/entity/hamiltionian_type.dart';
import 'package:discrete_math/core/graph/domain/entity/vertex_entity.dart';
import 'package:discrete_math/core/graph/domain/usecases/hamiltonian_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'hamiltonian_event.dart';
part 'hamiltonian_state.dart';

class HamiltonianBloc extends Bloc<HamiltonianEvent, HamiltonianState> {
  final HamiltonianUsecase service;

  HamiltonianBloc({required this.service}) : super(HamiltonianInitial()) {
    on<HamiltonianStart>((event, emit) async {
      emit(HamiltonianProcessing());

      final result = service.call(graph: event.graph);
      emit(HamiltonianResult(result));
    });
  }
}
