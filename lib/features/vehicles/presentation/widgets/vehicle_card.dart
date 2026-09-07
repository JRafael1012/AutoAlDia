import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/storage/storage_providers.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/models/vehicle_profile.dart';

/// Tarjeta de un vehículo en el garaje.
///
/// Muestra foto (o ícono por defecto), marca, modelo, año, placa, kilometraje,
/// indicador de vehículo activo y botones de editar / eliminar.
class VehicleCard extends ConsumerWidget {
  const VehicleCard({
    required this.vehicle,
    required this.onTap,
    required this.onSelectActive,
    required this.onEdit,
    required this.onDelete,
    super.key,
  });

  final VehicleProfile vehicle;
  final VoidCallback onTap;
  final VoidCallback onSelectActive;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final hasPhoto = vehicle.photoPath != null && vehicle.photoPath!.isNotEmpty;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: theme.cardTheme.color ?? AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: vehicle.isActive
              ? AppColors.primaryBlue
              : theme.colorScheme.outlineVariant.withAlpha(120),
          width: vehicle.isActive ? 2 : 1,
        ),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _thumbnail(ref, hasPhoto, theme),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            vehicle.brand,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimary,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (vehicle.isActive)
                          const _ActiveBadge(),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      vehicle.model,
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColors.textPrimary,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        _infoChip(
                          Icons.calendar_today_outlined,
                          vehicle.year?.toString() ?? '—',
                        ),
                        const SizedBox(width: 8),
                        _infoChip(
                          Icons.badge_outlined,
                          vehicle.plate ?? 'Sin placa',
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        _infoChip(
                          Icons.speed,
                          '${_formatKm(vehicle.odometerKm)} km',
                        ),
                        const SizedBox(width: 8),
                        _infoChip(
                          Icons.local_gas_station_outlined,
                          vehicle.fuelTypeLabel,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 4),
              _actions(theme),
            ],
          ),
        ),
      ),
    );
  }

  Widget _thumbnail(WidgetRef ref, bool hasPhoto, ThemeData theme) {
    Widget child;
    if (hasPhoto) {
      // La foto se guarda como ruta relativa; se resuelve a absoluta aquí.
      final storage = ref.watch(localStorageServiceProvider);
      child = FutureBuilder<File>(
        future: storage.resolveRelativeFile(vehicle.photoPath!),
        builder: (context, snapshot) {
          final file = snapshot.data;
          if (snapshot.hasError || file == null || !file.existsSync()) {
            return _defaultThumb(theme);
          }
          return ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.file(
              file,
              width: 64,
              height: 64,
              fit: BoxFit.cover,
              errorBuilder: (_, _, _) => _defaultThumb(theme),
            ),
          );
        },
      );
    } else {
      child = _defaultThumb(theme);
    }
    return SizedBox(width: 64, height: 64, child: child);
  }

  Widget _defaultThumb(ThemeData theme) {
    return Container(
      width: 64,
      height: 64,
      decoration: BoxDecoration(
        color: AppColors.primaryBlue.withAlpha(20),
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Icon(
        Icons.directions_car,
        color: AppColors.primaryBlue,
        size: 32,
      ),
    );
  }

  Widget _infoChip(IconData icon, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: AppColors.textSecondary),
        const SizedBox(width: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _actions(ThemeData theme) {
    return Column(
      children: [
        if (!vehicle.isActive)
          IconButton(
            icon: const Icon(Icons.check_circle_outline),
            tooltip: 'Marcar como activo',
            color: AppColors.primaryBlue,
            onPressed: onSelectActive,
          ),
        IconButton(
          icon: const Icon(Icons.edit_outlined),
          tooltip: 'Editar',
          color: AppColors.textSecondary,
          onPressed: onEdit,
        ),
        IconButton(
          icon: const Icon(Icons.delete_outline),
          tooltip: 'Eliminar',
          color: AppColors.statusDanger,
          onPressed: onDelete,
        ),
      ],
    );
  }

  static String _formatKm(double km) {
    return km == km.roundToDouble()
        ? km.toStringAsFixed(0)
        : km.toStringAsFixed(1);
  }
}

/// Insignia que indica el vehículo seleccionado como activo.
class _ActiveBadge extends StatelessWidget {
  const _ActiveBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: AppColors.statusSuccessContainer,
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.check_circle, size: 14, color: AppColors.statusSuccess),
          SizedBox(width: 4),
          Text(
            'Activo',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.statusSuccess,
            ),
          ),
        ],
      ),
    );
  }
}
