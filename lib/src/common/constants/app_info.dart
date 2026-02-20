/// Información de la aplicación (versión, etc.).
class AppInfo {
  AppInfo._();

  static const String version = '1.0.0';
  static const int buildNumber = 1;
  static String get versionDisplay => '$version ($buildNumber)';
}
