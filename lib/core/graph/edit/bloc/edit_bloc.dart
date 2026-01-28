import 'package:discrete_math/application/data/entity/vertex_entity.dart';
import 'package:discrete_math/core/graph/edit/service/edit_service.dart';
import 'package:discrete_math/core/graph/edit/state/edit_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditCubit extends Cubit<EditState> {
  final EditService service;

  EditCubit(this.service) : super(EditInitial());

  Future<void> createGraph({
    required String title,
    required Set<Vertex> data,
  }) async {
    emit(EditProcessing());

    try {
      final graph = await service.createGraph(title: title, data: data);
      print("EDITCUBIT ENDED WITH: $graph");
      emit(EditSuccess(graph));
    } catch (e, s) {
      print('EDIT ERROR: $e');
      print(s);
      emit(EditError(e.toString()));
    }
  }

  Future<void> editGraph({
    required Set<Vertex> data,
    required String id,
  }) async {
    emit(EditProcessing());
    try {
      final graph = await service.editGraph(data: data, id: id);
      print("EDITCUBIT ENDED WITH: $graph");

      emit(EditSuccess(graph));
    } catch (e) {
      print('EDIT ERROR: $e');

      emit(EditError(e.toString()));
    }
  }
}
