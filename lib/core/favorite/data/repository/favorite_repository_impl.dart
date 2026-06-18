import 'package:discrete_math/core/favorite/data/datasrouce/favorite_datasource.dart';
import 'package:discrete_math/core/favorite/domain/repostiory/favorite_repository.dart';
import 'package:discrete_math/core/graph/data/model/graph_model.dart';
import 'package:discrete_math/core/graph/domain/entity/graph_entity.dart';

class FavoriteRepositoryImpl implements FavoriteRepository {
  final FavoriteDatasource datasource;
  const FavoriteRepositoryImpl(this.datasource);
  @override
  Future<Set<String>> loadFavorites() async {
    try {
      return await datasource.loadFavorites();
    } catch (e) {
      throw Exception("EE");
    }
  }

  @override
  Future<void> toggle(GraphEntity graph) async {
    try {
      final graphModel = GraphModel.fromEntity(graph);
      await datasource.toggle(graphModel);
    } catch (e) {}
  }
}
