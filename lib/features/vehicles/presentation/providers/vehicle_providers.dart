import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/database/app_database_provider.dart';
import '../../../../core/storage/storage_providers.dart';
import '../../../auth/presentation/providers/auth_providers.dart';
import '../../data/vehicle_repository_impl.dart';
import '../../domain/models/vehicle_profile.dart';
import '../../domain/repository.dart';

part 'vehicle_providers.g.dart';

/// Proveedor del repositorio de vehículos basado en Drift.
@Riverpod(keepAlive: true)
VehicleRepository vehicleRepository(Ref ref) {
  return VehicleRepositoryImpl(ref.watch(appDatabaseProvider));
}

/// Lista de vehículos asociados al usuario actual.
@Riverpod(keepAlive: true)
class VehiclesListController extends _$VehiclesListController {
  @override
  Future<List<VehicleProfile>> build() async {
    final user = await ref.watch(profileControllerProvider.future);
    if (user == null) return [];
    return ref.watch(vehicleRepositoryProvider).getAll(user.id);
  }

  Future<void> reload() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final user = await ref.read(profileControllerProvider.future);
      if (user == null) return [];
      return ref.read(vehicleRepositoryProvider).getAll(user.id);
    });
  }

  /// Elimina un vehículo de la base de datos y limpia sus archivos físicos.
  ///
  /// Si el vehículo eliminado era el activo, se promueve automáticamente el
  /// más reciente de los restantes (M8). Si la limpieza física falla, la fila
  /// ya se borró: se registra el error con claridad y queda pendiente una
  /// limpieza huérfana futura.
  Future<void> deleteVehicle(VehicleProfile vehicle) async {
    final user = await ref.read(profileControllerProvider.future);
    final repo = ref.read(vehicleRepositoryProvider);

    await repo.delete(vehicle.id);
    try {
      await ref.read(localStorageServiceProvider).deleteVehicleDirectory(vehicle.id);
    } catch (e) {
      // M4: no revertir el DELETE en BD; registrar el fallo sin silenciarlo.
      // TODO(huérfanos): implementar una limpieza programada que escanee
      // `app_documents/vehicles/` y borre carpetas sin fila equivalente en BD.
      debugPrint(
        'AutoAlDía: no se pudieron eliminar los archivos del vehículo '
        '${vehicle.id} ($e). Quedan huérfanos; limpieza pendiente.',
      );
    }

    // M8: si se eliminó el activo, promover el más reciente de los restantes.
    if (vehicle.isActive && user != null) {
      final remaining = await repo.getAll(user.id);
      if (remaining.isNotEmpty) {
        final mostRecent = remaining
            .reduce((a, b) => a.createdAt.isAfter(b.createdAt) ? a : b);
        await repo.setActive(mostRecent.id, user.id);
      }
    }

    // Limpiar el vehículo activo en memoria si se eliminó el que estaba activo.
    ref.invalidate(activeVehicleControllerProvider);
    await reload();
  }
}

/// Proveedor del vehículo actualmente seleccionado (Vehículo Activo).
///
/// Todas las pantallas que filtran información por vehículo (combustible,
/// mantenimiento, gastos, dashboard) consumen este provider.
@Riverpod(keepAlive: true)
class ActiveVehicleController extends _$ActiveVehicleController {
  @override
  Future<VehicleProfile?> build() async {
    final user = await ref.watch(profileControllerProvider.future);
    if (user == null) return null;
    return ref.watch(vehicleRepositoryProvider).getActive(user.id);
  }

  /// Cambia el vehículo activo en la base de datos y actualiza el estado.
  Future<void> selectVehicle(int vehicleId) async {
    final user = await ref.read(profileControllerProvider.future);
    if (user == null) return;

    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref.read(vehicleRepositoryProvider).setActive(vehicleId, user.id);
      // Notificamos también a la lista para sincronizar banderas isActive
      ref.invalidate(vehiclesListControllerProvider);
      return ref.read(vehicleRepositoryProvider).getById(vehicleId);
    });
  }

  Future<void> reload() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final user = await ref.read(profileControllerProvider.future);
      if (user == null) return null;
      return ref.read(vehicleRepositoryProvider).getActive(user.id);
    });
  }
}
