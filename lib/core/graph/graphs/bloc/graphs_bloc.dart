import 'package:discrete_math/core/graph/graphs/service/graphs_service.dart';
import 'package:discrete_math/core/graph/graphs/state/graphs_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GraphsCubit extends Cubit<GraphsState> {
  final GraphsService service;

  GraphsCubit(this.service) : super(GraphsInitial());

  Future<void> loadGraphs() async {
    emit(GraphsLoading());
    try {
      final graphs = await service.getAllGraphs();
      emit(GraphsLoaded(graphs));
    } catch (e) {
      emit(GraphsError(e.toString()));
    }
  }
}
