import 'package:drift/drift.dart';

/// Bitácora de auditoría de acciones del usuario (created/updated/deleted).
///
/// Tabla transversal: registra eventos de cualquier módulo. La referencia a la
/// entidad es genérica ([entityType]/[entityId]) sin FK.
@TableIndex(name: 'activity_logs_entity_idx', columns: {#entityType, #entityId})
@TableIndex(name: 'activity_logs_created_idx', columns: {#createdAt})
class ActivityLogs extends Table {
  IntColumn get id => integer().autoIncrement()();

  /// created | updated | deleted.
  TextColumn get action => text().withLength(min: 1, max: 20)();

  TextColumn get entityType => text().withLength(min: 1, max: 30)();

  IntColumn get entityId => integer().nullable()();

  TextColumn get detail => text().nullable()();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}