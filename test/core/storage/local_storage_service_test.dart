import 'dart:io';
import 'package:autoaldia/core/storage/local_storage_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late Directory tempDir;
  late LocalStorageService storageService;

  setUp(() async {
    tempDir = await Directory.systemTemp.createTemp('autoaldia_storage_test_');
    storageService = LocalStorageService(
      documentsDirectoryProvider: () async => tempDir,
    );
  });

  tearDown(() async {
    if (await tempDir.exists()) {
      await tempDir.delete(recursive: true);
    }
  });

  test('getAppDocumentsDirectory retorna el directorio base configurado', () async {
    final dir = await storageService.getAppDocumentsDirectory();
    expect(dir.path, tempDir.path);
  });

  test('getVehicleDirectory crea la estructura de carpetas para un vehículo', () async {
    final vehicleDir = await storageService.getVehicleDirectory(10);
    expect(await vehicleDir.exists(), isTrue);
    expect(vehicleDir.path.endsWith('vehicles${Platform.pathSeparator}10'), isTrue);
  });

  test('saveVehiclePhoto copia y guarda la foto en la subcarpeta photos', () async {
    final tempSource = File('${tempDir.path}${Platform.pathSeparator}source.jpg');
    await tempSource.writeAsString('fake-image-bytes');

    final relativePath = await storageService.saveVehiclePhoto(
      vehicleId: 10,
      sourceFile: tempSource,
    );

    // Devuelve ruta relativa (convención del proyecto), nunca absoluta.
    expect(relativePath.contains('photos'), isTrue);
    final savedFile = await storageService.resolveRelativeFile(relativePath);
    expect(await savedFile.exists(), isTrue);
    expect(savedFile.path.contains(tempDir.path), isTrue);
    expect(await savedFile.readAsString(), 'fake-image-bytes');
  });

  test('deleteRelativeFile elimina el archivo relativo si existe', () async {
    final tempSource = File('${tempDir.path}${Platform.pathSeparator}source.jpg');
    await tempSource.writeAsString('fake-image-bytes');

    final relativePath = await storageService.saveVehiclePhoto(
      vehicleId: 10,
      sourceFile: tempSource,
    );

    final savedFile = await storageService.resolveRelativeFile(relativePath);
    expect(await savedFile.exists(), isTrue);

    await storageService.deleteRelativeFile(relativePath);
    expect(await savedFile.exists(), isFalse);
  });

  test('deleteRelativeFile con ruta vacía no borra nada', () async {
    final base = await storageService.getAppDocumentsDirectory();
    expect(base.path, tempDir.path);

    // No debe lanzar ni borrar la raíz de app_documents.
    await storageService.deleteRelativeFile('');
    expect(await base.exists(), isTrue);
  });

  test('deleteVehicleDirectory elimina en cascada física todos los archivos del vehículo', () async {
    final tempSource = File('${tempDir.path}${Platform.pathSeparator}source.jpg');
    await tempSource.writeAsString('fake-image-bytes');

    await storageService.saveVehiclePhoto(
      vehicleId: 10,
      sourceFile: tempSource,
    );

    final vehicleDir = await storageService.getVehicleDirectory(10);
    expect(await vehicleDir.exists(), isTrue);

    await storageService.deleteVehicleDirectory(10);
    expect(await vehicleDir.exists(), isFalse);
  });

  test('getBackupsDirectory crea la carpeta de respaldos', () async {
    final backupsDir = await storageService.getBackupsDirectory();
    expect(await backupsDir.exists(), isTrue);
    expect(backupsDir.path.endsWith('backups'), isTrue);
  });
}
