import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

// Tablas de features (cada feature define las suyas; aquí se registran todas).
import '../../features/alerts/data/tables/notifications_table.dart';
import '../../features/auth/data/tables/users_table.dart';
import '../../features/documents/data/tables/documents_table.dart';
import '../../features/expenses/data/tables/expenses_table.dart';
import '../../features/fuel/data/tables/fuel_records_table.dart';
import '../../features/insurance/data/tables/insurance_table.dart';
import '../../features/maintenance/data/tables/maintenance_table.dart';
import '../../features/maintenance/data/tables/maintenance_types_table.dart';
import '../../features/taxes/data/tables/taxes_table.dart';
import '../../features/vehicles/data/tables/vehicles_table.dart';

// Tablas transversales (infraestructura) que no pertenecen a una feature.
import 'tables/activity_logs_table.dart';
import 'tables/attachments_table.dart';

part 'app_database.g.dart';

/// Base de datos única de AutoAlDía (Drift sobre SQLite).
///
/// Esquema **versión 1** (esquema base del MVP). Regla de arquitectura: todo
/// cambio futuro se hace con una migración numerada en [migration], jamás
/// editando el esquema de una versión ya publicada (ver ARQUITECTURA.md).
@DriftDatabase(tables: [
  Users,
  Vehicles,
  FuelRecords,
  MaintenanceTypes,
  Maintenance,
  Expenses,
  Documents,
  Insurance,
  Taxes,
  Notifications,
  Attachments,
  ActivityLogs,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.e);

  /// Abre la base de datos en el directorio de documentos de la app.
  ///
  /// Decisión: la BD vive junto al resto de datos de usuario (fotos, facturas)
  /// para simplificar el respaldo local (backup = copiar el directorio).
  factory AppDatabase.open() {
    final executor = LazyDatabase(() async {
      final baseDir = await getApplicationDocumentsDirectory();
      final file = File(p.join(baseDir.path, 'autoaldia.sqlite'));
      return NativeDatabase.createInBackground(file);
    });
    return AppDatabase(executor);
  }

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) => m.createAll(),
        onUpgrade: (m, from, to) async {
          // Esquema base (v1). Las migraciones futuras se agregan numeradas:
          //   if (from < 2) { /* descripción + SQL de la migración 2 */ }
        },
        beforeOpen: (details) async {
          // Foreign keys ACTIVAS: sin esto, ON DELETE CASCADE no se aplica en
          // SQLite (cada conexión las desactiva por defecto).
          await customStatement('PRAGMA foreign_keys = ON');
        },
      );
}