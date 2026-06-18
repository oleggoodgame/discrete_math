import 'package:discrete_math/core/settings/theme/presentation/bloc/state_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ThemeDatasource {
  Future<void> saveTheme(AppThemeMode theme);
  AppThemeMode getTheme();
}

class ThemeLocalDataSource implements ThemeDatasource {
  static const _key = 'app_theme';

  final SharedPreferences prefs;

  ThemeLocalDataSource(this.prefs);
  @override
  Future<void> saveTheme(AppThemeMode theme) async {
    await prefs.setString(_key, theme.name);
  }

  @override
  AppThemeMode getTheme() {
    final value = prefs.getString(_key);
    if (value == null) return AppThemeMode.system;
    return AppThemeMode.fromString(value);
  }
}
