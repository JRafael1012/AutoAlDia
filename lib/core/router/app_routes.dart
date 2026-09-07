/// Rutas canónicas y nombres de ruta para AutoAlDía.
abstract class AppRoutes {
  // Rutas de autenticación y acceso
  static const String profileSetup = '/profile-setup';
  static const String pinLock = '/pin-lock';

  // Rutas principales dentro del Shell
  static const String dashboard = '/dashboard';
  static const String vehicles = '/vehicles';
  static const String fuel = '/fuel';
  static const String maintenance = '/maintenance';
  static const String expenses = '/expenses';

  // Rutas secundarias / utilitarias
  static const String documents = '/documents';
  static const String alerts = '/alerts';
  static const String reports = '/reports';
  static const String settings = '/settings';
}
