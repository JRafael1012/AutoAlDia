import 'package:drift/drift.dart';

import '../../../vehicles/data/tables/vehicles_table.dart';

/// Documentos del vehículo: SOAT, técnico-mecánica, seguros y otros.
///
/// `docType` es texto libre validado por la UI (soat, tecnicomecanica, seguro,
/// otro) para poder agregar tipos sin migración.
@TableIndex(name: 'documents_vehicle_idx', columns: {#vehicleId})
@TableIndex(name: 'documents_expiry_idx', columns: {#expiryDate})
class Documents extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get vehicleId => integer().references(Vehicles, #id, onDelete: KeyAction.cascade)();

  TextColumn get docType => text().withLength(min: 1, max: 30)();

  TextColumn get name => text().withLength(min: 1, max: 120)();

  TextColumn get number => text().nullable()();

  DateTimeColumn get issueDate => dateTime().nullable()();

  /// Fecha de vencimiento; base para las alertas de caducidad.
  DateTimeColumn get expiryDate => dateTime()();

  /// Ruta relativa al archivo dentro de `app_documents/documents/{id}/`.
  TextColumn get filePath => text().nullable()();

  /// Días de anticipación para la alerta de vencimiento.
  IntColumn get reminderDays => integer().withDefault(const Constant(15))();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}