import 'package:discrete_math/core/graph/domain/entity/graph_entity.dart';
import 'package:discrete_math/core/graph/domain/entity/vertex_entity.dart';
import 'package:discrete_math/core/graph/domain/repostiory/graph_repository.dart';

class EditGraphUsecase {
  final GraphRepository repository;
  const EditGraphUsecase(this.repository);
  Future<GraphEntity> call({required Set<Vertex> data, required String id}) {
    return repository.editGraph(data: data, id: id);
  }
}
