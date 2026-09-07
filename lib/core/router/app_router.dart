import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../features/auth/presentation/providers/auth_providers.dart';
import '../../features/auth/presentation/screens/pin_lock_screen.dart';
import '../../features/auth/presentation/screens/profile_setup_screen.dart';
import '../../features/vehicles/presentation/screens/vehicle_form_screen.dart';
import '../../features/vehicles/presentation/screens/vehicles_list_screen.dart';
import '../../shared/widgets/feature_placeholder_screen.dart';
import 'app_routes.dart';
import 'main_shell_scaffold.dart';

part 'app_router.g.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');

/// Notificador que avisa a GoRouter cuando cambia el estado de autenticación o bloqueo.
class RouterRefreshNotifier extends ChangeNotifier {
  RouterRefreshNotifier(Ref ref) {
    ref.listen(profileControllerProvider, (_, _) => notifyListeners());
    ref.listen(hasPinControllerProvider, (_, _) => notifyListeners());
    ref.listen(pinUnlockControllerProvider, (_, _) => notifyListeners());
  }
}

/// Proveedor oficial de GoRouter para AutoAlDía.
@Riverpod(keepAlive: true)
GoRouter goRouter(Ref ref) {
  final refreshNotifier = RouterRefreshNotifier(ref);
  ref.onDispose(refreshNotifier.dispose);

  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: AppRoutes.dashboard,
    refreshListenable: refreshNotifier,
    redirect: (BuildContext context, GoRouterState state) {
      final profileAsync = ref.read(profileControllerProvider);
      final hasPinAsync = ref.read(hasPinControllerProvider);
      final isUnlocked = ref.read(pinUnlockControllerProvider);

      // Si los providers aún están en carga inicial, no forzamos redirección
      if (profileAsync.isLoading || hasPinAsync.isLoading) {
        return null;
      }

      final profile = profileAsync.value;
      final hasPin = hasPinAsync.value ?? false;
      final location = state.matchedLocation;

      final isSetupRoute = location == AppRoutes.profileSetup;
      final isLockRoute = location == AppRoutes.pinLock;

      // 1. Si no existe un perfil configurado en el dispositivo:
      if (profile == null) {
        return isSetupRoute ? null : AppRoutes.profileSetup;
      }

      // 2. Si tiene PIN configurado pero la sesión actual aún no se ha desbloqueado:
      if (hasPin && !isUnlocked) {
        return isLockRoute ? null : AppRoutes.pinLock;
      }

      // 3. Si ya está autenticado y desbloqueado, no debe permanecer en setup o lock:
      if (isSetupRoute || isLockRoute) {
        return AppRoutes.dashboard;
      }

      return null;
    },
    routes: [
      // Rutas de inicio / acceso
      GoRoute(
        path: AppRoutes.profileSetup,
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const ProfileSetupScreen(),
      ),
      GoRoute(
        path: AppRoutes.pinLock,
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const PinLockScreen(),
      ),

      // Contenedor principal con pestañas (StatefulShellRoute)
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainShellScaffold(navigationShell: navigationShell);
        },
        branches: [
          // Pestaña 0: Inicio / Dashboard
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.dashboard,
                builder: (context, state) => const FeaturePlaceholderScreen(
                  title: 'Inicio',
                  icon: Icons.dashboard,
                  description:
                      'Resumen del vehículo activo, próximos vencimientos y gastos del mes.',
                ),
              ),
            ],
          ),

          // Pestaña 1: Vehículos
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.vehicles,
                builder: (context, state) => const VehiclesListScreen(),
              ),
            ],
          ),

          // Pestaña 2: Combustible
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.fuel,
                builder: (context, state) => const FeaturePlaceholderScreen(
                  title: 'Combustible',
                  icon: Icons.local_gas_station,
                  description:
                      'Registro de tanqueadas y análisis de consumo por kilómetro.',
                ),
              ),
            ],
          ),

          // Pestaña 3: Mantenimiento
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.maintenance,
                builder: (context, state) => const FeaturePlaceholderScreen(
                  title: 'Mantenimiento',
                  icon: Icons.build,
                  description:
                      'Historial de servicios mecánicos, catálogo de cambios e intervalos preventivos.',
                ),
              ),
            ],
          ),

          // Pestaña 4: Gastos
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.expenses,
                builder: (context, state) => const FeaturePlaceholderScreen(
                  title: 'Gastos',
                  icon: Icons.attach_money,
                  description:
                      'Control de egresos: parqueaderos, peajes, lavados y otros costos.',
                ),
              ),
            ],
          ),
        ],
      ),

      // Rutas secundarias (navegación completa sin barra inferior)
      GoRoute(
        path: AppRoutes.vehicleNew,
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const VehicleFormScreen(),
      ),
      GoRoute(
        path: AppRoutes.vehicleEdit,
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => VehicleFormScreen(
          vehicleId: int.tryParse(state.pathParameters['id'] ?? ''),
        ),
      ),
      GoRoute(
        path: AppRoutes.documents,
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const FeaturePlaceholderScreen(
          title: 'Documentos y Vencimientos',
          icon: Icons.folder,
          description:
              'Control de SOAT, Revisión Técnico-mecánica, Seguros e Impuestos.',
        ),
      ),
      GoRoute(
        path: AppRoutes.alerts,
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const FeaturePlaceholderScreen(
          title: 'Centro de Alertas',
          icon: Icons.notifications,
          description:
              'Recordatorios automáticos de fechas y kilometraje de mantenimiento.',
        ),
      ),
      GoRoute(
        path: AppRoutes.reports,
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const FeaturePlaceholderScreen(
          title: 'Reportes y Estadísticas',
          icon: Icons.bar_chart,
          description:
              'Gráficos de gastos por categoría, consumo promedio y costos por km.',
        ),
      ),
      GoRoute(
        path: AppRoutes.settings,
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const FeaturePlaceholderScreen(
          title: 'Configuración',
          icon: Icons.settings,
          description:
              'Preferencias de notificaciones, moneda, unidades métricas y seguridad.',
        ),
      ),
    ],
  );
}
