import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../errors/app_failure.dart';

/// Servicio para la gestión física de archivos en el dispositivo (fotos, documentos, recibos y respaldos).
///
/// Implementa la estructura física especificada en ARQUITECTURA.md:
/// app_documents/
/// ├── vehicles/
/// │   └── {vehicle_id}/
/// │       ├── photos/
/// │       ├── documents/
/// │       └── receipts/
/// └── backups/
class LocalStorageService {
  LocalStorageService({Future<Directory> Function()? documentsDirectoryProvider})
      : _documentsDirectoryProvider =
            documentsDirectoryProvider ?? getApplicationDocumentsDirectory;

  final Future<Directory> Function() _documentsDirectoryProvider;

  /// Obtiene la carpeta raíz de documentos de la aplicación.
  Future<Directory> getAppDocumentsDirectory() async {
    try {
      return await _documentsDirectoryProvider();
    } catch (e) {
      throw StorageFailure(
        'No se pudo acceder al almacenamiento del dispositivo.',
        cause: e,
      );
    }
  }

  /// Obtiene o crea la carpeta base para un vehículo específico.
  Future<Directory> getVehicleDirectory(int vehicleId) async {
    try {
      final base = await getAppDocumentsDirectory();
      final dir = Directory(p.join(base.path, 'vehicles', vehicleId.toString()));
      if (!await dir.exists()) {
        await dir.create(recursive: true);
      }
      return dir;
    } catch (e) {
      throw StorageFailure(
        'No se pudo crear el directorio del vehículo.',
        cause: e,
      );
    }
  }

  /// Guarda una fotografía de un vehículo.
  Future<File> saveVehiclePhoto({
    required int vehicleId,
    required File sourceFile,
  }) async {
    return _saveFileInVehicleFolder(
      vehicleId: vehicleId,
      subfolder: 'photos',
      sourceFile: sourceFile,
      prefix: 'vehicle_${vehicleId}_photo',
    );
  }

  /// Guarda un archivo o foto de documento (SOAT, RTM, Seguro, Impuesto).
  Future<File> saveDocumentFile({
    required int vehicleId,
    required File sourceFile,
    required String documentType,
  }) async {
    final sanitizedType = documentType.toLowerCase().replaceAll(RegExp(r'\s+'), '_');
    return _saveFileInVehicleFolder(
      vehicleId: vehicleId,
      subfolder: 'documents',
      sourceFile: sourceFile,
      prefix: 'doc_${sanitizedType}_${DateTime.now().millisecondsSinceEpoch}',
    );
  }

  /// Guarda una imagen o comprobante de gasto/recibo.
  Future<File> saveReceiptFile({
    required int vehicleId,
    required File sourceFile,
    required String category,
  }) async {
    final sanitizedCat = category.toLowerCase().replaceAll(RegExp(r'\s+'), '_');
    return _saveFileInVehicleFolder(
      vehicleId: vehicleId,
      subfolder: 'receipts',
      sourceFile: sourceFile,
      prefix: 'receipt_${sanitizedCat}_${DateTime.now().millisecondsSinceEpoch}',
    );
  }

  /// Elimina en cascada física todos los archivos y carpetas de un vehículo borrado.
  Future<void> deleteVehicleDirectory(int vehicleId) async {
    try {
      final base = await getAppDocumentsDirectory();
      final dir = Directory(p.join(base.path, 'vehicles', vehicleId.toString()));
      if (await dir.exists()) {
        await dir.delete(recursive: true);
      }
    } catch (e) {
      throw StorageFailure(
        'No se pudieron eliminar los archivos asociados al vehículo.',
        cause: e,
      );
    }
  }

  /// Obtiene o crea la carpeta dedicada para copias de seguridad locales.
  Future<Directory> getBackupsDirectory() async {
    try {
      final base = await getAppDocumentsDirectory();
      final dir = Directory(p.join(base.path, 'backups'));
      if (!await dir.exists()) {
        await dir.create(recursive: true);
      }
      return dir;
    } catch (e) {
      throw StorageFailure(
        'No se pudo acceder a la carpeta de respaldos.',
        cause: e,
      );
    }
  }

  Future<File> _saveFileInVehicleFolder({
    required int vehicleId,
    required String subfolder,
    required File sourceFile,
    required String prefix,
  }) async {
    try {
      final vehicleDir = await getVehicleDirectory(vehicleId);
      final targetFolder = Directory(p.join(vehicleDir.path, subfolder));
      if (!await targetFolder.exists()) {
        await targetFolder.create(recursive: true);
      }

      final ext = p.extension(sourceFile.path);
      final newFileName = '${prefix}_${DateTime.now().millisecondsSinceEpoch}$ext';
      final targetPath = p.join(targetFolder.path, newFileName);

      return await sourceFile.copy(targetPath);
    } catch (e) {
      throw StorageFailure(
        'Error al guardar el archivo en el dispositivo.',
        cause: e,
      );
    }
  }
}
