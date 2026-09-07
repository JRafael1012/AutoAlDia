import 'dart:io';

import 'package:autoaldia/core/database/app_database.dart';
import 'package:autoaldia/core/database/app_database_provider.dart';
import 'package:autoaldia/core/storage/local_storage_service.dart';
import 'package:autoaldia/core/storage/storage_providers.dart';
import 'package:autoaldia/features/vehicles/presentation/providers/vehicle_form_controller.dart';
import 'package:autoaldia/features/vehicles/presentation/providers/vehicle_providers.dart';
import 'package:drift/drift.dart' hide isNull, isNotNull;
import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Integración del módulo de vehículos', () {
    late AppDatabase db;
    late ProviderContainer container;
    late Directory tempDir;
    late LocalStorageService storageService;

    setUp(() async {
      db = AppDatabase(NativeDatabase.memory());
      tempDir =
          await Directory.systemTemp.createTemp('autoaldia_vehicles_test_');
      storageService = LocalStorageService(
        documentsDirectoryProvider: () async => tempDir,
      );
      container = ProviderContainer(
        overrides: [
          appDatabaseProvider.overrideWithValue(db),
          localStorageServiceProvider.overrideWithValue(storageService),
        ],
      );
    });

    tearDown(() async {
      container.dispose();
      await db.close();
      if (await tempDir.exists()) {
        await tempDir.delete(recursive: true);
      }
    });

    Future<int> crearPerfilUsuario() async {
      return db.into(db.users).insert(
            UsersCompanion.insert(
              name: 'Juan Pérez',
              email: const Value('juan@example.com'),
            ),
          );
    }

    test('crear un vehículo lo hace aparecer en la lista y queda activo',
        () async {
      final userId = await crearPerfilUsuario();

      final form = container.read(vehicleFormControllerProvider.notifier);
      form.startCreate();
      form.setBrand('Toyota');
      form.setModel('Corolla');
      form.setYear('2021');
      form.setPlate('ABC123');
      form.setOdometer('45000');
      form.setFuelType('gasolina');

      final saved = await form.save();
      expect(saved, isTrue);

      final list =
          await container.read(vehiclesListControllerProvider.future);
      expect(list.length, 1);
      expect(list.first.brand, 'Toyota');
      expect(list.first.model, 'Corolla');
      expect(list.first.plate, 'ABC123');
      expect(list.first.userId, userId);
      // El primer vehículo del usuario queda activo automáticamente.
      expect(list.first.isActive, isTrue);

      final active =
          await container.read(activeVehicleControllerProvider.future);
      expect(active?.id, list.first.id);
    });

    test('rechaza una placa duplicada para el mismo usuario', () async {
      await crearPerfilUsuario();

      Future<bool> guardarConPlaca(String placa) async {
        final form = container.read(vehicleFormControllerProvider.notifier);
        form.startCreate();
        form.setBrand('Mazda');
        form.setModel('3');
        form.setOdometer('10000');
        form.setFuelType('diesel');
        form.setPlate(placa);
        return form.save();
      }

      // Primer guardado: placa única, debe salir bien.
      expect(await guardarConPlaca('XYZ999'), isTrue);

      // Segundo guardado con la misma placa: debe rechazarse.
      expect(await guardarConPlaca('XYZ999'), isFalse);

      final list =
          await container.read(vehiclesListControllerProvider.future);
      expect(list.length, 1);
    });

    test('editar un vehículo actualiza sus datos', () async {
      await crearPerfilUsuario();

      final form = container.read(vehicleFormControllerProvider.notifier);
      form.startCreate();
      form.setBrand('Renault');
      form.setModel('Sandero');
      form.setOdometer('20000');
      form.setFuelType('gasolina');
      expect(await form.save(), isTrue);

      final created = (await container
              .read(vehiclesListControllerProvider.future))
          .first;

      form.startEdit(created);
      form.setModel('Duster');
      form.setOdometer('25000');
      // Mantener la placa vacía (no la cambiamos).
      expect(await form.save(), isTrue);

      final updated = (await container
              .read(vehiclesListControllerProvider.future))
          .first;
      expect(updated.model, 'Duster');
      expect(updated.odometerKm, 25000);
      expect(updated.id, created.id);
    });

    test('puede cambiar el vehículo activo entre varios', () async {
      await crearPerfilUsuario();

      final form = container.read(vehicleFormControllerProvider.notifier);

      // Crear el primero y segundo vehículo.
      form.startCreate();
      form.setBrand('Toyota');
      form.setModel('Corolla');
      form.setOdometer('10000');
      form.setFuelType('gasolina');
      expect(await form.save(), isTrue);

      form.startCreate();
      form.setBrand('Mazda');
      form.setModel('3');
      form.setOdometer('20000');
      form.setFuelType('diesel');
      expect(await form.save(), isTrue);

      final list =
          await container.read(vehiclesListControllerProvider.future);
      expect(list.length, 2);

      // El primero quedó activo (regla del primer vehículo).
      final corolla = list.firstWhere((v) => v.brand == 'Toyota');
      final mazda = list.firstWhere((v) => v.brand == 'Mazda');
      expect(corolla.isActive, isTrue);
      expect(mazda.isActive, isFalse);

      // Cambiar el activo al segundo.
      await container
          .read(activeVehicleControllerProvider.notifier)
          .selectVehicle(mazda.id);

      final updated =
          await container.read(activeVehicleControllerProvider.future);
      expect(updated?.id, mazda.id);

      // La lista refleja el nuevo activo (un solo activo a la vez).
      final refreshed =
          await container.read(vehiclesListControllerProvider.future);
      expect(refreshed.where((v) => v.isActive).length, 1);
      expect(refreshed.firstWhere((v) => v.isActive).id, mazda.id);
    });

    test('eliminar un vehículo lo quita de la lista', () async {
      await crearPerfilUsuario();

      final form = container.read(vehicleFormControllerProvider.notifier);
      form.startCreate();
      form.setBrand('Chevrolet');
      form.setModel('Spark');
      form.setOdometer('30000');
      form.setFuelType('gasolina');
      expect(await form.save(), isTrue);

      final created = (await container
              .read(vehiclesListControllerProvider.future))
          .first;

      await container
          .read(vehiclesListControllerProvider.notifier)
          .deleteVehicle(created);

      final list =
          await container.read(vehiclesListControllerProvider.future);
      expect(list, isEmpty);
    });

    test('guarda y conserva los datos adicionales del vehículo', () async {
      await crearPerfilUsuario();

      final form = container.read(vehicleFormControllerProvider.notifier);
      form.startCreate();
      form.setBrand('BMW');
      form.setModel('320i');
      form.setOdometer('50000');
      form.setFuelType('gasolina');
      form.setTankCapacity('45.5');
      form.setAcquisitionDate('2023-05-01');
      form.setPurchaseValue('120000000');
      form.setCurrentEstimatedValue('110000000');
      form.setColor('Azul');
      form.setVin('WBA3A5C50K0142567');
      form.setVehicleType('carro');
      form.setObservations('Comprado de agencia');
      expect(await form.save(), isTrue);

      final created = (await container
              .read(vehiclesListControllerProvider.future))
          .first;
      expect(created.tankCapacity, 45.5);
      expect(created.acquisitionDate, DateTime(2023, 5, 1));
      expect(created.purchaseValue, 120000000);
      expect(created.currentEstimatedValue, 110000000);
      expect(created.color, 'Azul');
      expect(created.vin, 'WBA3A5C50K0142567');
      expect(created.vehicleType, 'carro');
      expect(created.observations, 'Comprado de agencia');

      // Al editar y guardar sin tocar los campos opcionales se conservan.
      form.startEdit(created);
      form.setOdometer('51000');
      expect(await form.save(), isTrue);
      final updated = (await container
              .read(vehiclesListControllerProvider.future))
          .first;
      expect(updated.tankCapacity, 45.5);
      expect(updated.color, 'Azul');
      expect(updated.vin, 'WBA3A5C50K0142567');
    });

    test('persiste la foto como ruta relativa y la resuelve al eliminar',
        () async {
      await crearPerfilUsuario();

      final form = container.read(vehicleFormControllerProvider.notifier);
      form.startCreate();
      form.setBrand('Toyota');
      form.setModel('Corolla');
      form.setOdometer('10000');
      form.setFuelType('gasolina');

      final sourcePhoto = File(
        '${tempDir.path}${Platform.pathSeparator}source_photo.jpg',
      );
      await sourcePhoto.writeAsString('fake-photo-bytes');
      form.setSelectedImagePath(sourcePhoto.path);

      expect(await form.save(), isTrue);

      final created = (await container
              .read(vehiclesListControllerProvider.future))
          .first;
      expect(created.photoPath, isNotNull);
      expect(created.photoPath!.contains('vehicles'), isTrue);
      expect(created.photoPath!.startsWith(tempDir.path), isFalse);

      // La ruta relativa se resuelve a un archivo existente.
      final saved = await storageService
          .resolveRelativeFile(created.photoPath!);
      expect(await saved.exists(), isTrue);

      // Al borrar el vehículo, el archivo físico desaparece.
      await container
          .read(vehiclesListControllerProvider.notifier)
          .deleteVehicle(created);
      expect(await saved.exists(), isFalse);
    });

    test('al eliminar el vehículo activo promueve el más reciente (M8)',
        () async {
      await crearPerfilUsuario();

      final form = container.read(vehicleFormControllerProvider.notifier);

      form.startCreate();
      form.setBrand('Toyota');
      form.setModel('Corolla');
      form.setOdometer('10000');
      form.setFuelType('gasolina');
      expect(await form.save(), isTrue);

      form.startCreate();
      form.setBrand('Mazda');
      form.setModel('3');
      form.setOdometer('20000');
      form.setFuelType('diesel');
      expect(await form.save(), isTrue);

      // El primero quedó activo; lo eliminamos.
      final list =
          await container.read(vehiclesListControllerProvider.future);
      final corolla = list.firstWhere((v) => v.brand == 'Toyota');
      expect(corolla.isActive, isTrue);

      await container
          .read(vehiclesListControllerProvider.notifier)
          .deleteVehicle(corolla);

      final remaining =
          await container.read(vehiclesListControllerProvider.future);
      expect(remaining.length, 1);
      expect(remaining.single.brand, 'Mazda');
      expect(remaining.single.isActive, isTrue);

      final active =
          await container.read(activeVehicleControllerProvider.future);
      expect(active?.id, remaining.single.id);
    });
  });
}
