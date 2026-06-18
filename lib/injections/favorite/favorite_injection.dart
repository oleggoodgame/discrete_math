import 'package:discrete_math/core/favorite/data/datasrouce/favorite_datasource.dart';
import 'package:discrete_math/core/favorite/data/repository/favorite_repository_impl.dart';
import 'package:discrete_math/core/favorite/domain/repostiory/favorite_repository.dart';
import 'package:discrete_math/core/favorite/presentation/bloc/favorite_cubit.dart';
import 'package:get_it/get_it.dart';

class FavoriteInjection {
  final GetIt sl;
  const FavoriteInjection(this.sl);
  void init() {
    //datasource & repostiory
    sl.registerLazySingleton<FavoriteDatasource>(
      () => FavoriteDatasourceImlp(),
    );
    sl.registerLazySingleton<FavoriteRepository>(
      () => FavoriteRepositoryImpl(sl<FavoriteDatasource>()),
    );
    //usecase
    // sl.registerLazySingleton(() => CreateGraphUsecase(sl<GraphRepository>()));

    //bloc
    sl.registerFactory<FavoriteCubit>(
      () => FavoriteCubit(sl<FavoriteRepository>()),
    );
  }
}
