import 'package:discrete_math/core/graph/detour/event/detour_event.dart';
import 'package:discrete_math/core/graph/detour/service/detour_service.dart';
import 'package:discrete_math/core/graph/detour/state/detour_state.dart';
import 'package:discrete_math/application/data/entity/vertex_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetourBloc extends Bloc<DetourEvent, DetourState> {
  final DetourService service;

  DetourBloc({required this.service})
    : super(DetourInitial()) {
    on<StartDetour>((event, emit) async {
      emit(DetourProcessing());
      print("Start Detour");
      await for (final step in service.detourStepsFixed(
        start: event.start,
        find: event.find,
        graph: event.graph,
      )) {
              print("STEP: $step");

        emit(DetourResult(step));
      }

      await Future.delayed(const Duration(seconds: 10));
      print("reset");
      final reset = event.graph.values
          .map((v) => v.copyWith(state: VertexState.idle))
          .toSet();

      emit(DetourResult(reset));
    });
  }

}