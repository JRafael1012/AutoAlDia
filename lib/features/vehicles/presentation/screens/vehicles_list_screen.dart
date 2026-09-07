import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/errors/app_failure.dart';
import '../../../../core/router/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/models/vehicle_profile.dart';
import '../providers/vehicle_providers.dart';
import '../widgets/vehicle_card.dart';

/// Pantalla "Mis Vehículos" (garaje): lista todos los vehículos del usuario.
///
/// Reemplaza al `FeaturePlaceholderScreen` en la ruta `AppRoutes.vehicles`.
class VehiclesListScreen extends ConsumerWidget {
  const VehiclesListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vehiclesAsync = ref.watch(vehiclesListControllerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Mis Vehículos')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push(AppRoutes.vehicleNew),
        icon: const Icon(Icons.add),
        label: const Text('Agregar'),
      ),
      body: vehiclesAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => _ErrorView(
          message: error is AppFailure
              ? error.message
              : 'No se pudieron cargar los vehículos.',
          onRetry: () => ref.read(vehiclesListControllerProvider.notifier).reload(),
        ),
        data: (vehicles) => vehicles.isEmpty
            ? const _EmptyView()
            : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: vehicles.length,
                itemBuilder: (context, index) {
                  final vehicle = vehicles[index];
                  return VehicleCard(
                    vehicle: vehicle,
                    onTap: () => _openForm(context, vehicle),
                    onSelectActive: () =>
                        _selectActive(context, ref, vehicle),
                    onEdit: () => _openForm(context, vehicle),
                    onDelete: () => _confirmDelete(context, ref, vehicle),
                  );
                },
              ),
      ),
    );
  }

  void _openForm(BuildContext context, VehicleProfile vehicle) {
    context.push(
      AppRoutes.vehicleEdit.replaceFirst(':id', vehicle.id.toString()),
    );
  }

  Future<void> _selectActive(
    BuildContext context,
    WidgetRef ref,
    VehicleProfile vehicle,
  ) async {
    if (vehicle.isActive) return;
    try {
      await ref
          .read(activeVehicleControllerProvider.notifier)
          .selectVehicle(vehicle.id);
    } on AppFailure catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.message)));
      }
    }
  }

  Future<void> _confirmDelete(
    BuildContext context,
    WidgetRef ref,
    VehicleProfile vehicle,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Eliminar vehículo'),
        content: Text(
          '¿Deseas eliminar "${vehicle.brand} ${vehicle.model}"? '
          'Se perderá todo su historial asociado.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.statusDanger,
            ),
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );

    if (confirmed != true || !context.mounted) return;

    final messenger = ScaffoldMessenger.of(context);
    try {
      await ref
          .read(vehiclesListControllerProvider.notifier)
          .deleteVehicle(vehicle.id);
      messenger.showSnackBar(
        SnackBar(
          content: Text('El vehículo "${vehicle.brand} ${vehicle.model}" fue eliminado.'),
        ),
      );
    } on AppFailure catch (e) {
      messenger.showSnackBar(SnackBar(content: Text(e.message)));
    }
  }
}

class _EmptyView extends StatelessWidget {
  const _EmptyView();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.primaryBlue.withAlpha(25),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.directions_car,
                size: 48,
                color: AppColors.primaryBlue,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Aún no tienes vehículos',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            const Text(
              'Agrega tu primer vehículo para empezar a registrar combustible, '
              'mantenimiento y gastos.',
              style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: () => context.push(AppRoutes.vehicleNew),
              icon: const Icon(Icons.add),
              label: const Text('Agregar vehículo'),
            ),
          ],
        ),
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, size: 48, color: AppColors.statusDanger),
            const SizedBox(height: 16),
            Text(
              message,
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            FilledButton.tonal(
              onPressed: onRetry,
              child: const Text('Reintentar'),
            ),
          ],
        ),
      ),
    );
  }
}
