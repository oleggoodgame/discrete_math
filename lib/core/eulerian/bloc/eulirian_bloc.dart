import 'package:discrete_math/core/eulerian/event/eulirian_event.dart';
import 'package:discrete_math/core/eulerian/service/eulirian_service.dart';
import 'package:discrete_math/core/eulerian/state/eulirian_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EulerianBloc extends Bloc<EulerianEvent, EulirianState> {
  final EulirianService service;

  EulerianBloc({required this.service}) : super(EulirianInitial()) {
    on<EulerianStart>((event, emit) async {
      emit(EulirianProcessing());

      await for (final result in service.eulerianService(
        vertices: event.vertices,
      )) {
        emit(EulirianResult(type: result));
      }
    });
  }
}
