import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/database/app_database_provider.dart';
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
