import 'package:discrete_math/core/graph/domain/entity/eulerian_type.dart';
import 'package:discrete_math/core/graph/domain/entity/vertex_entity.dart';
import 'package:discrete_math/core/graph/domain/usecases/eulerian_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'eulirian_event.dart';
part 'eulirian_state.dart';

class EulerianBloc extends Bloc<EulerianEvent, EulirianState> {
  final EulerianUsecase service;

  EulerianBloc({required this.service}) : super(EulirianInitial()) {
    on<EulerianStart>((event, emit) async {
      emit(EulirianProcessing());

      final result = await service(vertices: event.vertices);
      emit(EulirianResult(type: result));
    });
  }
}
