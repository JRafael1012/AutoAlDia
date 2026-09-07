import 'package:drift/drift.dart';

import '../../../auth/data/tables/users_table.dart';
import '../../../vehicles/data/tables/vehicles_table.dart';

/// Notificaciones programadas e historial de alertas.
///
/// `type`: doc_expiry | maintenance_due | km_reached (validado por la UI).
/// `relatedEntity`/`relatedId`: origen de la alerta (documents, maintenance…)
/// sin FK por ser referencia genérica.
@TableIndex(name: 'notifications_vehicle_idx', columns: {#vehicleId})
@TableIndex(name: 'notifications_scheduled_idx', columns: {#userId, #scheduledAt, #isRead})
class Notifications extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get userId => integer().references(Users, #id, onDelete: KeyAction.cascade)();

  /// Nullable: alertas globales que no dependen de un vehículo.
  IntColumn get vehicleId => integer().references(Vehicles, #id, onDelete: KeyAction.cascade).nullable()();

  TextColumn get type => text().withLength(min: 1, max: 30)();

  TextColumn get title => text().withLength(min: 1, max: 120)();

  TextColumn get body => text().nullable()();

  TextColumn get relatedEntity => text().nullable()();

  IntColumn get relatedId => integer().nullable()();

  DateTimeColumn get scheduledAt => dateTime().nullable()();

  BoolColumn get isSent => boolean().withDefault(const Constant(false))();

  /// true si el usuario ya leyó la notificación (badge de no leídas).
  BoolColumn get isRead => boolean().withDefault(const Constant(false))();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}