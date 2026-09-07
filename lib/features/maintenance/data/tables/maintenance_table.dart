import 'package:drift/drift.dart';

import '../../../vehicles/data/tables/vehicles_table.dart';
import 'maintenance_types_table.dart';

/// Registros de mantenimiento del vehículo.
///
/// Recordatorios por fecha ([nextDueDate]) y/o por kilometraje ([nextDueKm]).
@TableIndex(name: 'maintenance_vehicle_date_idx', columns: {#vehicleId, #date})
class Maintenance extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get vehicleId => integer().references(Vehicles, #id, onDelete: KeyAction.cascade)();

  /// Nullable: un mantenimiento puede no corresponder al catálogo.
  IntColumn get typeId => integer().references(MaintenanceTypes, #id).nullable()();

  DateTimeColumn get date => dateTime()();

  RealColumn get odometerKm => real().nullable()();

  TextColumn get title => text().withLength(min: 1, max: 120)();

  /// Decisión: monto como entero (unidad mínima de la moneda).
  IntColumn get cost => integer()();

  /// Recordatorio por fecha (si se definió uno).
  DateTimeColumn get nextDueDate => dateTime().nullable()();

  /// Recordatorio por kilometraje (si se definió uno).
  RealColumn get nextDueKm => real().nullable()();

  TextColumn get notes => text().nullable()();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}