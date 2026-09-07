import 'package:drift/drift.dart';

import '../../../auth/data/tables/users_table.dart';

/// Vehículos del usuario.
///
/// Decisión (ajuste aprovado): placa única **por usuario**, por eso el índice
/// único es compuesto ({userId, plate}) y no global sobre plate. Evita
/// colisiones en reinstalaciones, dispositivos compartidos o futura
/// sincronización multiusuario.
@TableIndex(name: 'vehicles_user_plate_unique', columns: {#userId, #plate}, unique: true)
class Vehicles extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get userId => integer().references(Users, #id, onDelete: KeyAction.cascade)();

  TextColumn get brand => text().withLength(min: 1, max: 80)();

  TextColumn get model => text().withLength(min: 1, max: 80)();

  IntColumn get year => integer().nullable()();

  TextColumn get plate => text().withLength(min: 1, max: 20).nullable()();

  /// Kilometraje actual del vehículo. No es monto: admite decimales.
  RealColumn get odometerKm => real()();

  /// gasolina | diesel | electrico | hibrido. TEXT libre validado por la UI.
  TextColumn get fuelType => text().withLength(min: 1, max: 20)();

  /// activo | inactivo | vendido.
  TextColumn get status => text().withDefault(const Constant('activo'))();

  /// Ruta relativa a la foto dentro de `app_documents/vehicles/{id}/photos/`.
  TextColumn get photoPath => text().nullable()();

  /// Vehículo seleccionado por el usuario (para módulos como combustible/gastos).
  BoolColumn get isActive => boolean().withDefault(const Constant(false))();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}