import 'package:drift/drift.dart';

import '../../../vehicles/data/tables/vehicles_table.dart';

/// Gastos generales del vehículo (peajes, lavado, parqueadero, etc.).
///
/// `category` es texto libre validado por la UI en el MVP; un catálogo de
/// categorías se revisa para v1.5 (evita migración para agregar categorías).
@TableIndex(name: 'expenses_vehicle_date_idx', columns: {#vehicleId, #date})
class Expenses extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get vehicleId => integer().references(Vehicles, #id, onDelete: KeyAction.cascade)();

  TextColumn get category => text().withLength(min: 1, max: 60)();

  /// Decisión: monto como entero (unidad mínima de la moneda).
  IntColumn get amount => integer()();

  DateTimeColumn get date => dateTime()();

  TextColumn get description => text().nullable()();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}