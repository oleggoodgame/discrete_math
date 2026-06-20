import 'package:discrete_math/core/graph/data/datasrouce/graph_datasource.dart';
import 'package:discrete_math/core/graph/data/model/graph_model.dart';
import 'package:discrete_math/core/graph/data/model/vertex_model.dart';
import 'package:discrete_math/core/graph/domain/entity/vertex_entity.dart';
import 'package:discrete_math/core/graph/domain/repostiory/graph_repository.dart';
import 'package:discrete_math/core/graph/domain/entity/graph_entity.dart';
import 'package:discrete_math/shared/errors/error.dart';

class GraphRepositoryImpl implements GraphRepository {
  final GraphDatasource graphDatasource;
  const GraphRepositoryImpl(this.graphDatasource);
  @override
  Future<void> deleteGraph(GraphEntity graph) async {
    try {
      final graphModel = GraphModel.fromEntity(graph);
      await graphDatasource.deleteGraph(graphModel);
    } catch (e) {
      print('graph failed: $e');
      throw const GraphFailure();
    }
  }

  @override
  Future<List<GraphEntity>> getAllGraphs() async {
    try {
      return await graphDatasource.getAllGraphs();
    } catch (e) {
      print('graph failed: $e');
      throw const GraphFailure();
    }
  }

  @override
  Future<GraphEntity> createGraph({
    required String title,
    required Set<Vertex> data,
  }) async {
    try {
      final vertexModel = VertexModel.fromSetVertex(data);
      return await graphDatasource.createGraph(title: title, data: vertexModel);
    } catch (e) {
      print('graph failed: $e');
      throw const GraphFailure();
    }
  }

  @override
  Future<GraphEntity> editGraph({
    required Set<Vertex> data,
    required String id,
  }) async {
    try {
      final vertexModel = VertexModel.fromSetVertex(data);
      return await graphDatasource.editGraph(id: id, data: vertexModel);
    } catch (e) {
      print('graph failed: $e');
      throw const GraphFailure();
    }
  }
}
