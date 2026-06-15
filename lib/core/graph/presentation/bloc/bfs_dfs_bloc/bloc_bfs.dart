import 'package:discrete_math/core/graph/domain/entity/vertex_entity.dart';
import 'package:discrete_math/core/graph/domain/usecases/bfs_usecase.dart';
import 'package:discrete_math/core/graph/presentation/bloc/bfs_dfs_bloc/graph_event.dart';
import 'package:discrete_math/core/graph/presentation/bloc/bfs_dfs_bloc/graph_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class BfsBloc extends Bloc<GraphEvent, GraphState> {
  final BfsUsecase bfsUsecase;

  BfsBloc({required this.bfsUsecase})
    : super(GraphInitial()) {
    on<StartGraph>((event, emit) async {
      emit(GraphProcessing());
      print("Start BLOC");
      await for (final step in bfsUsecase.call(
        start: event.start,
        graph: event.graph,
      )) {
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
