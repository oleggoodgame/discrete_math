import 'package:discrete_math/application/data/entity/graph/graph_entity.dart';
import 'package:discrete_math/core/graph/favorite/service/favorite_service.dart';
import 'package:discrete_math/core/graph/favorite/state/favorite_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  final FavoriteService service;

  FavoriteCubit(this.service) : super(FavoriteInitial());

  Future<void> load() async {
    emit(FavoriteLoading());
    try {
      final favorites = await service.loadFavorites();
      emit(FavoriteLoaded(favorites));
    } catch (e) {
      emit(FavoriteError(e.toString()));
    }
  }

  Future<void> toggle(GraphEntity graph) async {
    try {
      await service.toggle(graph);
      final favorites = await service.loadFavorites();
      emit(FavoriteLoaded(favorites));
    } catch (e) {
      emit(FavoriteError(e.toString()));
    }
  }

  // bool isFavorite(GraphEntity graph) {
  //   if (state is FavoriteLoaded) {
  //     return (state as FavoriteLoaded)
  //         state.
  //         .any((id) => id == graph.id);
  //   }
  //   return false;
  // }
}
