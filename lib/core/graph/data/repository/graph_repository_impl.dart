import 'package:discrete_math/core/graph/data/datasrouce/graph_datasource.dart';
import 'package:discrete_math/core/graph/data/model/graph_model.dart';
import 'package:discrete_math/core/graph/domain/repostiory/graph_repository.dart';
import 'package:discrete_math/core/graph/domain/entity/graph_entity.dart';

class GraphRepositoryImpl implements GraphRepository {
  final GraphDatasource graphDatasource;
  const GraphRepositoryImpl(this.graphDatasource);
  @override
  Future<void> deleteGraph(GraphEntity graph) async {
    try {
      final graphModel = GraphModel.fromEntity(graph);
      await graphDatasource.deleteGraph(graphModel);
    } catch (e) {
      return;
    }
  }

  @override
  Future<List<GraphEntity>> getAllGraphs() async {
    try {
      return await graphDatasource.getAllGraphs();
    } catch (e) {
      throw Exception(""); // Тут додам в мабйтньому нормальний опис помилки
    }
  }

}
