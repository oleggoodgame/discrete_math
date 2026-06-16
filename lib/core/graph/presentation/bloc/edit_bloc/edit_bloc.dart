import 'package:discrete_math/core/graph/domain/entity/graph_entity.dart';
import 'package:discrete_math/core/graph/domain/entity/vertex_entity.dart';
import 'package:discrete_math/core/graph/domain/usecases/create_graph_usecase.dart';
import 'package:discrete_math/core/graph/domain/usecases/edit_graph_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'edit_state.dart';

class EditCubit extends Cubit<EditState> {
  final EditGraphUsecase editGraphUsecase;
  final CreateGraphUsecase createGraphUsecase;
  EditCubit({required this.editGraphUsecase, required this.createGraphUsecase})
    : super(EditInitial());

  Future<void> createGraph({
    required String title,
    required Set<Vertex> data,
  }) async {
    emit(EditProcessing());

    try {
      final graph = await createGraphUsecase(title: title, data: data);
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
      final graph = await editGraphUsecase(data: data, id: id);
      print("EDITCUBIT ENDED WITH: $graph");

      emit(EditSuccess(graph));
    } catch (e) {
      print('EDIT ERROR: $e');

      emit(EditError(e.toString()));
    }
  }
}
