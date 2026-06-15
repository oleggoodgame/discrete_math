import 'package:discrete_math/core/graph/domain/entity/graph_entity.dart';

abstract class FavoriteRepository {
  Future<void> toggle(GraphEntity graph);
  Future<Set<String>> loadFavorites();
}