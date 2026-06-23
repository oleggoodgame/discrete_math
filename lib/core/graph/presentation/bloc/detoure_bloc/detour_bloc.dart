import 'package:discrete_math/core/graph/domain/usecases/detour_usecase.dart';
import 'package:discrete_math/core/graph/domain/entity/vertex_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'detour_state.dart';
part 'detour_event.dart';

class DetourBloc extends Bloc<DetourEvent, DetourState> {
  final DetourUsecase detourUsecase;

  DetourBloc({required this.detourUsecase}) : super(DetourInitial()) {
    on<StartDetour>((event, emit) async {
      try {
        emit(DetourProcessing());
        print("Start Detour");
        final result = await detourUsecase(
          start: event.start,
          find: event.find,
          graph: event.graph,
        );
        emit(DetourResult(result));
        await Future.delayed(const Duration(seconds: 5));
        print("reset");
        final reset = event.graph.values
            .map((v) => v.copyWith(state: VertexState.idle))
            .toSet();

        emit(DetourResult(reset));
      } catch (ex) {
        emit(DetourError(ex.toString()));
      }
    });
  }
}
