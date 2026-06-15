import 'package:discrete_math/core/graph/domain/repostiory/graph_repository.dart';
import 'package:discrete_math/core/graph/domain/entity/graph_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'graphs_state.dart';
class GraphsCubit extends Cubit<GraphsState> {
  final GraphRepository graphRepository;
  GraphsCubit(this.graphRepository) : super(GraphsInitial());

  Future<void> loadGraphs() async {
    emit(GraphsLoading());
    try {
      final graphs = await graphRepository.getAllGraphs();
      emit(GraphsLoaded(graphs));
    } catch (e) {
      emit(GraphsError(e.toString()));
    }
  }

  Future<void> deleteGraph(GraphEntity graph) async {
    emit(GraphsLoading());
    try {
      await graphRepository.deleteGraph(graph);
      final graphs = await graphRepository.getAllGraphs();
      emit(GraphsLoaded(graphs));
    } catch (e) {
      emit(GraphsError(e.toString()));
    }
  }
}
