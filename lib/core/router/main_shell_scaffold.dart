import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/vehicles/presentation/providers/vehicle_providers.dart';
import '../theme/app_colors.dart';
import 'app_routes.dart';

/// Contenedor principal con barra de navegación persistente (Shell) para AutoAlDía.
///
/// Aloja las 5 pestañas primarias del MVP:
/// 1. Inicio / Dashboard
/// 2. Vehículos
/// 3. Combustible
/// 4. Mantenimiento
/// 5. Gastos
class MainShellScaffold extends ConsumerWidget {
  const MainShellScaffold({
    required this.navigationShell,
    super.key,
  });

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeVehicleAsync = ref.watch(activeVehicleControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            const Text(
              'AutoAlDía',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            activeVehicleAsync.when(
              data: (vehicle) => Text(
                vehicle != null
                    ? '${vehicle.brand} ${vehicle.model} • ${vehicle.plate ?? "Sin placa"}'
                    : 'Sin vehículo seleccionado',
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.normal,
                ),
              ),
              loading: () => const SizedBox.shrink(),
              error: (_, _) => const SizedBox.shrink(),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none),
            tooltip: 'Alertas',
            onPressed: () => context.push(AppRoutes.alerts),
          ),
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            tooltip: 'Configuración',
            onPressed: () => context.push(AppRoutes.settings),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: AppColors.primaryBlue,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Icon(Icons.directions_car, size: 40, color: Colors.white),
                  const SizedBox(height: 8),
                  const Text(
                    'AutoAlDía',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Todo tu vehículo, siempre al día.',
                    style: TextStyle(
                      color: Colors.white.withAlpha(204),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.folder_outlined),
              title: const Text('Documentos y Vencimientos'),
              onTap: () {
                Navigator.pop(context);
                context.push(AppRoutes.documents);
              },
            ),
            ListTile(
              leading: const Icon(Icons.bar_chart_outlined),
              title: const Text('Reportes y Estadísticas'),
              onTap: () {
                Navigator.pop(context);
                context.push(AppRoutes.reports);
              },
            ),
            ListTile(
              leading: const Icon(Icons.notifications_outlined),
              title: const Text('Centro de Alertas'),
              onTap: () {
                Navigator.pop(context);
                context.push(AppRoutes.alerts);
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.settings_outlined),
              title: const Text('Configuración'),
              onTap: () {
                Navigator.pop(context);
                context.push(AppRoutes.settings);
              },
            ),
          ],
        ),
      ),
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: (index) {
          navigationShell.goBranch(
            index,
            initialLocation: index == navigationShell.currentIndex,
          );
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.dashboard_outlined),
            selectedIcon: Icon(Icons.dashboard),
            label: 'Inicio',
          ),
          NavigationDestination(
            icon: Icon(Icons.directions_car_outlined),
            selectedIcon: Icon(Icons.directions_car),
            label: 'Vehículos',
          ),
          NavigationDestination(
            icon: Icon(Icons.local_gas_station_outlined),
            selectedIcon: Icon(Icons.local_gas_station),
            label: 'Combustible',
          ),
          NavigationDestination(
            icon: Icon(Icons.build_outlined),
            selectedIcon: Icon(Icons.build),
            label: 'Mantenimiento',
          ),
          NavigationDestination(
            icon: Icon(Icons.attach_money_outlined),
            selectedIcon: Icon(Icons.attach_money),
            label: 'Gastos',
          ),
        ],
      ),
    );
  }
}
