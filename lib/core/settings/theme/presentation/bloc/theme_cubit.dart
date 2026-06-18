import 'package:discrete_math/core/settings/theme/domain/repository/theme_repository.dart';
import 'package:discrete_math/core/settings/theme/presentation/bloc/state_theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeCubit extends Cubit<AppThemeMode> {
  final ThemeRepository dataSource;

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
