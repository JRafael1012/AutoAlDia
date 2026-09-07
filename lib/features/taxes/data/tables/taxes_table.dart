import 'package:drift/drift.dart';

import '../../../vehicles/data/tables/vehicles_table.dart';

/// Impuestos del vehículo (rodamiento, tránsito, etc.).
///
/// `taxType` es texto libre validado por la UI en el MVP.
@TableIndex(name: 'taxes_vehicle_idx', columns: {#vehicleId})
@TableIndex(name: 'taxes_due_date_idx', columns: {#dueDate})
class Taxes extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get vehicleId => integer().references(Vehicles, #id, onDelete: KeyAction.cascade)();

  TextColumn get taxType => text().withLength(min: 1, max: 60)();

  /// Año fiscal del impuesto (ej. 2026).
  IntColumn get taxYear => integer()();

  /// Decisión: monto como entero (unidad mínima de la moneda).
  IntColumn get amount => integer()();

  DateTimeColumn get dueDate => dateTime()();

  /// pendiente | pagado | vencido.
  TextColumn get status => text().withDefault(const Constant('pendiente'))();

  /// Nullable: null = impuesto aún no pagado.
  DateTimeColumn get paidDate => dateTime().nullable()();

  /// Ruta relativa del comprobante de pago dentro de `app_documents/...`.
  TextColumn get receiptPath => text().nullable()();

  IntColumn get reminderDays => integer().withDefault(const Constant(15))();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}