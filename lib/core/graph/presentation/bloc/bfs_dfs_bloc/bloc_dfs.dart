import 'package:discrete_math/core/graph/domain/entity/vertex_entity.dart';
import 'package:discrete_math/core/graph/domain/usecases/dfs_usecase.dart';
import 'package:discrete_math/core/graph/presentation/bloc/bfs_dfs_bloc/graph_event.dart';
import 'package:discrete_math/core/graph/presentation/bloc/bfs_dfs_bloc/graph_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DfsBloc extends Bloc<GraphEvent, GraphState> {
  final DfsUsecase dfsUsecase;

  DfsBloc({required this.dfsUsecase}) : super(GraphInitial()) {
    on<StartGraph>((event, emit) async {
      emit(GraphProcessing());
      print("Start DFS");
      await for (final step in dfsUsecase.call(
        start: event.start,
        graph: event.graph,
      )) {
        // print("STEP: $step");

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

}
