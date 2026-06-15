import 'package:discrete_math/core/graph/domain/entity/graph_entity.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'favorite_provider.g.dart';

@riverpod
class FavoriteProvider extends _$FavoriteProvider {
  @override
  Set<String> build() => {};

  bool isFavorite(GraphEntity graph) {
    return state.any((id) => id == graph.id);
  }
  bool toggle(GraphEntity graph) {
    final newState = {...state};

    final exists = newState.any((id) => id == graph.id);

    if (exists) {
      newState.removeWhere((id) => id == graph.id);
    } else {
      newState.add(graph.id);
    }

    state = newState;
    return !exists;
  }
  void setAll(Set<String> ids) {
    state = {...ids};
  }
}

