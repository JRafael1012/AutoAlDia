import 'package:autoaldia/core/database/app_database.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase db;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
  });

  tearDown(() async {
    await db.close();
  });

  group('Integridad de Base de Datos (Drift/SQLite)', () {
    test('PRAGMA foreign_keys está activo y el borrado en cascada funciona al eliminar un vehículo', () async {
      // 1. Crear usuario base
      final userId = await db.into(db.users).insert(
            UsersCompanion.insert(
              name: 'Juan Pérez',
              email: const Value('juan@example.com'),
            ),
          );

      // 2. Crear vehículo asociado
      final vehicleId = await db.into(db.vehicles).insert(
            VehiclesCompanion.insert(
              userId: userId,
              brand: 'Mazda',
              model: '3',
              odometerKm: 45000.0,
              fuelType: 'gasolina',
              plate: const Value('ABC123'),
            ),
          );

      // 3. Crear registros dependientes
      await db.into(db.fuelRecords).insert(
            FuelRecordsCompanion.insert(
              vehicleId: vehicleId,
              date: DateTime.now(),
              odometerKm: 45200.0,
              liters: 10.5,
              unitPrice: 15500,
              totalCost: 162750,
              isFullTank: true,
            ),
          );

      await db.into(db.expenses).insert(
            ExpensesCompanion.insert(
              vehicleId: vehicleId,
              category: 'peaje',
              amount: 12000,
              date: DateTime.now(),
            ),
          );

      await db.into(db.documents).insert(
            DocumentsCompanion.insert(
              vehicleId: vehicleId,
              docType: 'soat',
              name: 'SOAT 2026',
              expiryDate: DateTime.now().add(const Duration(days: 365)),
            ),
          );

      // Verificar que los registros existen
      final initialFuel = await (db.select(db.fuelRecords)..where((r) => r.vehicleId.equals(vehicleId))).get();
      final initialExpenses = await (db.select(db.expenses)..where((r) => r.vehicleId.equals(vehicleId))).get();
      final initialDocs = await (db.select(db.documents)..where((r) => r.vehicleId.equals(vehicleId))).get();

      expect(initialFuel.length, 1);
      expect(initialExpenses.length, 1);
      expect(initialDocs.length, 1);

      // 4. Eliminar el vehículo
      final deletedCount = await (db.delete(db.vehicles)..where((v) => v.id.equals(vehicleId))).go();
      expect(deletedCount, 1);

      // 5. Verificar que ON DELETE CASCADE eliminó todos los registros asociados
      final remainingFuel = await (db.select(db.fuelRecords)..where((r) => r.vehicleId.equals(vehicleId))).get();
      final remainingExpenses = await (db.select(db.expenses)..where((r) => r.vehicleId.equals(vehicleId))).get();
      final remainingDocs = await (db.select(db.documents)..where((r) => r.vehicleId.equals(vehicleId))).get();

      expect(remainingFuel, isEmpty);
      expect(remainingExpenses, isEmpty);
      expect(remainingDocs, isEmpty);
    });

    test('Convención monetaria almacena enteros sin pérdida de precisión', () async {
      final userId = await db.into(db.users).insert(
            UsersCompanion.insert(name: 'Carlos'),
          );

      final vehicleId = await db.into(db.vehicles).insert(
            VehiclesCompanion.insert(
              userId: userId,
              brand: 'Toyota',
              model: 'Corolla',
              odometerKm: 12000,
              fuelType: 'hibrido',
            ),
          );

      // Monto grande en COP (ej. $1.500.000)
      const expenseAmount = 1500000;
      await db.into(db.expenses).insert(
            ExpensesCompanion.insert(
              vehicleId: vehicleId,
              category: 'mantenimiento_mayor',
              amount: expenseAmount,
              date: DateTime.now(),
            ),
          );

      final inserted = await (db.select(db.expenses)..where((e) => e.vehicleId.equals(vehicleId))).getSingle();
      expect(inserted.amount, expenseAmount);
    });
  });
}
