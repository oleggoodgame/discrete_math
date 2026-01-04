import 'package:discrete_math/core/bfs/event/bfs_event.dart';
import 'package:discrete_math/core/bfs/service/service_bfs.dart';
import 'package:discrete_math/core/bfs/state/bfs_state.dart';
import 'package:discrete_math/data/entity/vertex_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GraphBloc extends Bloc<GraphEvent, GraphState> {
  final GraphService service;

  GraphBloc({required this.service})
    : super(GraphInitial()) {
    on<StartBfs>((event, emit) async {
      emit(GraphProcessing());
      print("Start BLOC");
      await for (final step in service.bfsSteps(
        start: event.start,
        graph: event.graph,
      )) {
              print("STEP: $step");

        emit(GraphResult(step));
      }

      await Future.delayed(const Duration(seconds: 10));
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
