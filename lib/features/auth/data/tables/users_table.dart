import 'package:drift/drift.dart';

/// Perfil local del usuario.
///
/// En el MVP existe una única fila (una fila por instalación, sin cuentas).
/// Decisión: `currency` vive aquí (configuración global del usuario), no en
/// cada tabla financiera, para poder escalar a multi-moneda sin migrar el
/// resto de tablas. El MVP asume una sola moneda activa por usuario.
class Users extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get name => text().withLength(min: 1, max: 120)();

  TextColumn get email => text().nullable()();

  TextColumn get phone => text().nullable()();

  /// Moneda activa del usuario. Unidad mínima = 1 peso (COP) en el MVP.
  TextColumn get currency => text().withDefault(const Constant('COP'))();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}