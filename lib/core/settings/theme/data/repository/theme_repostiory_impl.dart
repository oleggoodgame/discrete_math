import 'package:discrete_math/core/settings/theme/data/datasource/theme_datasource.dart';
import 'package:discrete_math/core/settings/theme/domain/repository/theme_repository.dart';
import 'package:discrete_math/core/settings/theme/presentation/bloc/state_theme.dart';

class ThemeRepostioryImpl implements ThemeRepository {
  final ThemeDatasource datasource;
  const ThemeRepostioryImpl(this.datasource);
  @override
  AppThemeMode getTheme() {
    try {
      return datasource.getTheme();
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<void> saveTheme(AppThemeMode theme) async {
    try {
      return await datasource.saveTheme(theme);
    } catch (e) {
      throw Exception();
    }
  }
}
