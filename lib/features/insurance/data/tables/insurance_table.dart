import 'package:drift/drift.dart';

import '../../../vehicles/data/tables/vehicles_table.dart';

/// Pólizas de seguro del vehículo.
///
/// [endDate] alimenta las alertas de vencimiento del seguro.
@TableIndex(name: 'insurance_vehicle_idx', columns: {#vehicleId})
@TableIndex(name: 'insurance_end_date_idx', columns: {#endDate})
class Insurance extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get vehicleId => integer().references(Vehicles, #id, onDelete: KeyAction.cascade)();

  TextColumn get provider => text().withLength(min: 1, max: 120)();

  TextColumn get policyNumber => text().nullable()();

  TextColumn get coverage => text().nullable()();

  /// todo_riesgo | responsabilidad_civil | otro.
  TextColumn get policyType => text()();

  DateTimeColumn get startDate => dateTime().nullable()();

  DateTimeColumn get endDate => dateTime()();

  /// Decisión: monto como entero (unidad mínima de la moneda).
  IntColumn get premium => integer().nullable()();

  /// anual | semestral | trimestral | mensual.
  TextColumn get paymentFrequency => text().withDefault(const Constant('anual'))();

  TextColumn get notes => text().nullable()();

  IntColumn get reminderDays => integer().withDefault(const Constant(15))();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}