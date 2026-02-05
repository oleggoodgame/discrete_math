import 'package:discrete_math/core/theme/state/state_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeLocalDataSource {
  static const _key = 'app_theme';

  final SharedPreferences prefs;

  ThemeLocalDataSource(this.prefs);

  Future<void> saveTheme(AppThemeMode theme) async {
    await prefs.setString(_key, theme.name);
  }

  AppThemeMode getTheme() {
    final value = prefs.getString(_key);
    if (value == null) return AppThemeMode.system;
    return AppThemeMode.fromString(value);
  }
}
