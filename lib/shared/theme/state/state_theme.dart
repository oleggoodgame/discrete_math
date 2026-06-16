enum AppThemeMode {
  loading,
  system,
  light,
  dark;

  static AppThemeMode fromString(String value) {
    return AppThemeMode.values.firstWhere(
      (e) => e.name == value,
      orElse: () => AppThemeMode.system,
    );
  }

  String get value => name;
}
