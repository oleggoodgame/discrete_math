import 'package:discrete_math/core/settings/theme/presentation/bloc/state_theme.dart';

abstract class ThemeRepository {
  Future<void> saveTheme(AppThemeMode theme);
  AppThemeMode getTheme();
}