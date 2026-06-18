import 'package:discrete_math/core/graph/domain/entity/graph_entity.dart';
import 'package:discrete_math/core/graph/domain/entity/vertex_entity.dart';
import 'package:discrete_math/core/graph/domain/repostiory/graph_repository.dart';

class CreateGraphUsecase {
  final GraphRepository repository;
  const CreateGraphUsecase(this.repository);
  Future<GraphEntity> call({
    required String title,
    required Set<Vertex> data,
  }) {
    return repository.createGraph(data: data, title: title);
  }
}
