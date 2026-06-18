import 'package:discrete_math/core/graph/domain/entity/graph_entity.dart';
import 'package:discrete_math/core/graph/domain/entity/vertex_entity.dart';

abstract class GraphRepository {
  Future<List<GraphEntity>> getAllGraphs();
  Future<void> deleteGraph(GraphEntity graph);
  Future<GraphEntity> createGraph({
    required String title,
    required Set<Vertex> data,
  });
  Future<GraphEntity> editGraph({
    required Set<Vertex> data,
    required String id,
  });
}
