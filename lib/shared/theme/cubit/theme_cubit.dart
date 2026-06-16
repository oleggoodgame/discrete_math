import 'package:discrete_math/shared/theme/service/service_theme.dart';
import 'package:discrete_math/shared/theme/state/state_theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeCubit extends Cubit<AppThemeMode> {
  final ThemeLocalDataSource dataSource;

  ThemeCubit(this.dataSource) : super(AppThemeMode.loading) {
    _loadTheme();
  }

  void _loadTheme() {
    final theme = dataSource.getTheme();
    emit(theme);
  }

  Future<void> setTheme(AppThemeMode theme) async {
    emit(theme);
    await dataSource.saveTheme(theme);
  }
}
