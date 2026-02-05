import 'package:discrete_math/core/graph/bfs/service/service_bfs.dart';
import 'package:discrete_math/application/data/entity/graph/event/graph_event.dart';
import 'package:discrete_math/application/data/entity/graph/state/graph_state.dart';
import 'package:discrete_math/application/data/entity/vertex_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BfsBloc extends Bloc<GraphEvent, GraphState> {
  final BfsService service;

  BfsBloc({required this.service})
    : super(GraphInitial()) {
    on<StartGraph>((event, emit) async {
      emit(GraphProcessing());
      print("Start BLOC");
      await for (final step in service.bfsSteps(
        start: event.start,
        graph: event.graph,
      )) {
              print("STEP: $step");

        emit(GraphResult(step));
      }

      await Future.delayed(const Duration(seconds: 5));
      print("reset");
      final reset = event.graph.values
          .map((v) => v.copyWith(state: VertexState.idle))
          .toSet();

      emit(GraphResult(reset));
    });
  }

  // void _onStartBfs(StartBfs event, Emitter<GraphState> emit) {
  //   emit(GraphProcessing());

  //   final result = service.bfsSteps(start: event.start, graph: graph);

  //   emit(GraphResult(result));
  // }
}
