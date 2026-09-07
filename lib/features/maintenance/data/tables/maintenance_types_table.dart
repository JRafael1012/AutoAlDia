import 'package:drift/drift.dart';

/// Catálogo de tipos de mantenimiento (aceite, frenos, alineación, etc.).
///
/// El catálogo base se siembra con datos de desarrollo aislados (dev seeder),
/// nunca mezclados con la lógica de producción.
class MaintenanceTypes extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get name => text().withLength(min: 1, max: 80).unique()();

  /// Intervalo recomendado en km (opcional; depende del tipo).
  RealColumn get recommendedIntervalKm => real().nullable()();

  /// Intervalo recomendado en meses (opcional).
  IntColumn get recommendedIntervalMonths => integer().nullable()();

  /// Descripción del servicio (opcional) — ej. "Reemplaza aceite y filtro".
  TextColumn get description => text().nullable()();

  /// true si el tipo fue creado por el usuario (no viene del catálogo base).
  BoolColumn get isCustom => boolean().withDefault(const Constant(false))();
}