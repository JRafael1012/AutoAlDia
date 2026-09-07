import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';
import '../tables/vehicles_table.dart';

part 'vehicles_dao.g.dart';

/// Consultas de Drift para la tabla `vehicles`.
@DriftAccessor(tables: [Vehicles])
class VehiclesDao extends DatabaseAccessor<AppDatabase> with _$VehiclesDaoMixin {
  VehiclesDao(super.db);

  Future<List<Vehicle>> getAll(int userId) {
    return (select(vehicles)
          ..where((v) => v.userId.equals(userId))
          ..orderBy([(v) => OrderingTerm.asc(v.brand)]))
        .get();
  }

  Future<Vehicle?> getById(int id) {
    return (select(vehicles)..where((v) => v.id.equals(id))).getSingleOrNull();
  }

  Future<Vehicle?> getActive(int userId) {
    return (select(vehicles)
          ..where((v) => v.userId.equals(userId) & v.isActive.equals(true))
          ..limit(1))
        .getSingleOrNull();
  }

  /// Busca un vehículo por placa dentro del mismo usuario (placa única por usuario).
  Future<Vehicle?> getByPlate(int userId, String plate) {
    return (select(vehicles)
          ..where(
            (v) => v.userId.equals(userId) & v.plate.equals(plate.trim()),
          )
          ..limit(1))
        .getSingleOrNull();
  }

  /// true si el usuario tiene al menos un vehículo registrado.
  Future<bool> hasAny(int userId) {
    return (select(vehicles)..where((v) => v.userId.equals(userId)))
        .get()
        .then((rows) => rows.isNotEmpty);
  }

  Future<int> insertVehicle(VehiclesCompanion entry) {
    return into(vehicles).insert(entry);
  }

  Future<int> updateVehicle(VehiclesCompanion entry) {
    return (update(vehicles)..where((v) => v.id.equals(entry.id.value)))
        .write(entry);
  }

  /// Desmarca todos los vehículos del usuario (previo a marcar uno activo).
  Future<int> clearActive(int userId) {
    return (update(vehicles)..where((v) => v.userId.equals(userId)))
        .write(const VehiclesCompanion(isActive: Value(false)));
  }

  Future<int> deleteVehicle(int id) {
    return (delete(vehicles)..where((v) => v.id.equals(id))).go();
  }
}