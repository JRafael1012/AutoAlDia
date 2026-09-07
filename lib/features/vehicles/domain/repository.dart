import 'models/vehicle_profile.dart';

/// Interfaz abstracta del repositorio de vehículos.
///
/// `domain/` no depende de Drift ni Flutter: la implementación concreta vive
/// en `data/`.
abstract interface class VehicleRepository {
  /// Devuelve todos los vehículos del usuario ordenados por nombre.
  Future<List<VehicleProfile>> getAll(int userId);

  /// Devuelve el vehículo marcado como activo, o `null` si no hay ninguno.
  Future<VehicleProfile?> getActive(int userId);

  /// Devuelve un vehículo por su ID.
  Future<VehicleProfile?> getById(int id);

  /// Crea un vehículo nuevo. El primer vehículo se marca automáticamente
  /// como activo.
  Future<VehicleProfile> create({
    required int userId,
    required String brand,
    required String model,
    required double odometerKm,
    required String fuelType,
    int? year,
    String? plate,
  });

  /// Actualiza campos de un vehículo existente.
  Future<VehicleProfile> update({
    required int id,
    String? brand,
    String? model,
    int? year,
    String? plate,
    double? odometerKm,
    String? fuelType,
    String? status,
    String? photoPath,
  });

  /// Marca un vehículo como activo y desactiva los demás del mismo usuario.
  Future<void> setActive(int vehicleId, int userId);

  /// Elimina un vehículo y todos sus datos asociados (cascada).
  Future<void> delete(int id);
}
