import 'package:drift/drift.dart';

/// Archivos adjuntos (fotos, facturas, PDFs) asociados a entidades.
///
/// Decisión: la referencia es polimórfica ([entityType]/[entityId]) y por eso
/// NO usa FK ni `ON DELETE CASCADE`: el borrado de archivos físicos es
/// responsabilidad del servicio de almacenamiento (`core/storage`), que
/// elimina la carpeta correspondiente por código. Este es un caso de prueba
/// explícito, no un comportamiento implícito de la base de datos.
@TableIndex(name: 'attachments_entity_idx', columns: {#entityType, #entityId})
class Attachments extends Table {
  IntColumn get id => integer().autoIncrement()();

  /// vehicle | document | maintenance | expense (validado por la UI).
  TextColumn get entityType => text().withLength(min: 1, max: 30)();

  IntColumn get entityId => integer()();

  /// Ruta relativa dentro de `app_documents/...`. Nunca rutas absolutas.
  TextColumn get path => text()();

  TextColumn get mimeType => text().nullable()();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}