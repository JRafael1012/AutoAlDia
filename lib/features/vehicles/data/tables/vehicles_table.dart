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

  /// Capacidad del tanque en litros (opcional).
  RealColumn get tankCapacity => real().nullable()();

  /// Fecha de adquisición del vehículo (opcional).
  DateTimeColumn get acquisitionDate => dateTime().nullable()();

  /// Decisión: monto como entero (unidad mínima de la moneda).
  IntColumn get purchaseValue => integer().nullable()();

  /// Decisión: monto como entero (unidad mínima de la moneda).
  IntColumn get currentEstimatedValue => integer().nullable()();

  /// Color del vehículo (opcional).
  TextColumn get color => text().withLength(min: 1, max: 40).nullable()();

  /// Número de identificación vehicular (VIN) (opcional).
  TextColumn get vin => text().withLength(min: 1, max: 30).nullable()();

  /// carro | moto | camioneta | otro. TEXT libre validado por la UI.
  TextColumn get vehicleType => text().withLength(min: 1, max: 30).nullable()();

  /// Observaciones o notas libres (opcional).
  TextColumn get observations => text().withLength(min: 1, max: 500).nullable()();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}