import 'package:drift/drift.dart';

import '../../../core/database/app_database.dart';
import '../../../core/errors/app_failure.dart';
import '../domain/models/vehicle_profile.dart';
import '../domain/repository.dart';
import 'daos/vehicles_dao.dart';

/// Implementación del repositorio de vehículos sobre Drift.
class VehicleRepositoryImpl implements VehicleRepository {
  VehicleRepositoryImpl(this._db);

  final AppDatabase _db;
  late final VehiclesDao _dao = VehiclesDao(_db);

  @override
  Future<List<VehicleProfile>> getAll(int userId) async {
    try {
      final rows = await _dao.getAll(userId);
      return rows.map(_toProfile).toList();
    } catch (e) {
      throw const DatabaseFailure('No se pudieron cargar los vehículos.');
    }
  }

  @override
  Future<VehicleProfile?> getActive(int userId) async {
    try {
      final row = await _dao.getActive(userId);
      return row == null ? null : _toProfile(row);
    } catch (e) {
      throw const DatabaseFailure('No se pudo leer el vehículo activo.');
    }
  }

  @override
  Future<VehicleProfile?> getById(int id) async {
    try {
      final row = await _dao.getById(id);
      return row == null ? null : _toProfile(row);
    } catch (e) {
      throw const DatabaseFailure('No se pudo cargar el vehículo.');
    }
  }

  @override
  Future<VehicleProfile?> findByPlate(int userId, String plate) async {
    try {
      if (plate.trim().isEmpty) return null;
      final row = await _dao.getByPlate(userId, plate);
      return row == null ? null : _toProfile(row);
    } catch (e) {
      throw const DatabaseFailure('No se pudo verificar la placa.');
    }
  }

  @override
  Future<VehicleProfile> create({
    required int userId,
    required String brand,
    required String model,
    required double odometerKm,
    required String fuelType,
    int? year,
    String? plate,
  }) async {
    try {
      final isFirst = !await _dao.hasAny(userId);
      final id = await _dao.insertVehicle(
        VehiclesCompanion.insert(
          userId: userId,
          brand: brand.trim(),
          model: model.trim(),
          odometerKm: odometerKm,
          fuelType: fuelType,
          year: Value(year),
          plate: Value(plate?.trim()),
          // Decisión: el primer vehículo queda automáticamente activo para
          // que el dashboard tenga algo que mostrar de inmediato.
          isActive: Value(isFirst),
        ),
      );
      final row = await _dao.getById(id);
      if (row == null) {
        throw const NotFoundFailure('El vehículo no se creó correctamente.');
      }
      return _toProfile(row);
    } on AppFailure {
      rethrow;
    } catch (e) {
      throw const DatabaseFailure(
        'No se pudo guardar el vehículo. Intenta de nuevo.',
      );
    }
  }

  @override
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
  }) async {
    try {
      final existing = await _dao.getById(id);
      if (existing == null) {
        throw const NotFoundFailure('El vehículo ya no existe.');
      }
      final entry = VehiclesCompanion(
        id: Value(id),
        brand: Value(brand?.trim() ?? existing.brand),
        model: Value(model?.trim() ?? existing.model),
        year: Value(year ?? existing.year),
        plate: Value(plate?.trim() ?? existing.plate),
        odometerKm: Value(odometerKm ?? existing.odometerKm),
        fuelType: Value(fuelType ?? existing.fuelType),
        status: Value(status ?? existing.status),
        photoPath: Value(photoPath ?? existing.photoPath),
        updatedAt: Value(DateTime.now()),
      );
      await _dao.updateVehicle(entry);
      final row = await _dao.getById(id);
      if (row == null) {
        throw const NotFoundFailure('El vehículo ya no existe.');
      }
      return _toProfile(row);
    } on AppFailure {
      rethrow;
    } catch (e) {
      throw const DatabaseFailure(
        'No se pudo actualizar el vehículo. Intenta de nuevo.',
      );
    }
  }

  @override
  Future<void> setActive(int vehicleId, int userId) async {
    try {
      await _db.transaction(() async {
        await _dao.clearActive(userId);
        await _dao.updateVehicle(
          VehiclesCompanion(
            id: Value(vehicleId),
            isActive: const Value(true),
            updatedAt: Value(DateTime.now()),
          ),
        );
      });
    } catch (e) {
      throw const DatabaseFailure('No se pudo cambiar el vehículo activo.');
    }
  }

  @override
  Future<void> delete(int id) async {
    try {
      await _dao.deleteVehicle(id);
    } catch (e) {
      throw const DatabaseFailure('No se pudo eliminar el vehículo.');
    }
  }

  VehicleProfile _toProfile(Vehicle row) {
    return VehicleProfile(
      id: row.id,
      userId: row.userId,
      brand: row.brand,
      model: row.model,
      year: row.year,
      plate: row.plate,
      odometerKm: row.odometerKm,
      fuelType: row.fuelType,
      status: row.status,
      photoPath: row.photoPath,
      isActive: row.isActive,
      createdAt: row.createdAt,
      updatedAt: row.updatedAt,
    );
  }
}