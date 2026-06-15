import 'package:discrete_math/core/graph/domain/entity/graph_entity.dart';

abstract class GraphRepository {
  Future<List<GraphEntity>> getAllGraphs();
  Future<void> deleteGraph(GraphEntity graph);
}
