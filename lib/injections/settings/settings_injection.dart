import 'package:discrete_math/core/settings/theme/data/datasource/theme_datasource.dart';
import 'package:discrete_math/core/settings/theme/data/repository/theme_repostiory_impl.dart';
import 'package:discrete_math/core/settings/theme/domain/repository/theme_repository.dart';
import 'package:discrete_math/core/settings/theme/presentation/bloc/theme_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsInjection {
  final GetIt sl;
  const SettingsInjection(this.sl);

  // Робимо функцію Future, щоб дочекатися SharedPreferences
  Future<void> init() async {
    // 1. Реєструємо сам SharedPreferences
    final sharedPreferences = await SharedPreferences.getInstance();
    sl.registerSingleton<SharedPreferences>(sharedPreferences);

    // 2. Datasource & Repository
    // Тепер передаємо SharedPreferences з GetIt в конструктор!
    sl.registerLazySingleton<ThemeDatasource>(
      () => ThemeLocalDataSource(sl<SharedPreferences>()),
    );

    sl.registerLazySingleton<ThemeRepository>(
      () => ThemeRepostioryImpl(sl<ThemeDatasource>()),
    );

    // 3. Bloc / Cubit
    sl.registerFactory<ThemeCubit>(() => ThemeCubit(sl<ThemeRepository>()));
  }
}
