import 'package:drift/drift.dart';

import '../../../vehicles/data/tables/vehicles_table.dart';

/// Registros de carga de combustible.
///
/// El consumo se calcula entre tanque lleno y tanque lleno en dominio puro
/// (nunca SQL), usando [odometerKm], [liters] y [isFullTank].
@TableIndex(name: 'fuel_records_vehicle_date_idx', columns: {#vehicleId, #date})
class FuelRecords extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get vehicleId => integer().references(Vehicles, #id, onDelete: KeyAction.cascade)();

  DateTimeColumn get date => dateTime()();

  RealColumn get odometerKm => real()();

  RealColumn get liters => real()();

  /// Precio por litro. Decisión: montos como enteros (unidad mínima). Ver
  /// `core/constants/money_convention.md`. COP = pesos sin decimales.
  IntColumn get unitPrice => integer()();

  /// Costo total de la carga (litros x precio, redondeado al entero).
  IntColumn get totalCost => integer()();

  /// true = tanque lleno (referencia para el cálculo de consumo).
  BoolColumn get isFullTank => boolean()();

  TextColumn get station => text().nullable()();

  TextColumn get notes => text().nullable()();
}