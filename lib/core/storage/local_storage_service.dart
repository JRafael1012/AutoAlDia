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
  ///
  /// Devuelve la **ruta relativa** (p. ej. `vehicles/3/photos/...`) para
  /// persistir en la base de datos. La ruta absoluta se reconstruye en
  /// tiempo de ejecución con [resolveRelativeFile].
  Future<String> saveVehiclePhoto({
    required int vehicleId,
    required File sourceFile,
  }) {
    return _saveFileInVehicleFolder(
      vehicleId: vehicleId,
      subfolder: 'photos',
      sourceFile: sourceFile,
      prefix: 'vehicle_${vehicleId}_photo',
    );
  }

  /// Guarda un archivo o foto de documento (SOAT, RTM, Seguro, Impuesto).
  ///
  /// Devuelve la ruta relativa dentro de `app_documents/...`.
  Future<String> saveDocumentFile({
    required int vehicleId,
    required File sourceFile,
    required String documentType,
  }) {
    final sanitizedType = documentType.toLowerCase().replaceAll(RegExp(r'\s+'), '_');
    return _saveFileInVehicleFolder(
      vehicleId: vehicleId,
      subfolder: 'documents',
      sourceFile: sourceFile,
      prefix: 'doc_${sanitizedType}_${DateTime.now().millisecondsSinceEpoch}',
    );
  }

  /// Guarda una imagen o comprobante de gasto/recibo.
  ///
  /// Devuelve la ruta relativa dentro de `app_documents/...`.
  Future<String> saveReceiptFile({
    required int vehicleId,
    required File sourceFile,
    required String category,
  }) {
    final sanitizedCat = category.toLowerCase().replaceAll(RegExp(r'\s+'), '_');
    return _saveFileInVehicleFolder(
      vehicleId: vehicleId,
      subfolder: 'receipts',
      sourceFile: sourceFile,
      prefix: 'receipt_${sanitizedCat}_${DateTime.now().millisecondsSinceEpoch}',
    );
  }

  /// Convierte una ruta relativa persistida en un [File] absoluto.
  ///
  /// La base de datos nunca guarda rutas absolutas (convención del proyecto,
  /// ver `attachments_table`); la resolución ocurre solo al mostrar o borrar.
  Future<File> resolveRelativeFile(String relativePath) async {
    try {
      final base = await getAppDocumentsDirectory();
      return File(p.join(base.path, relativePath));
    } catch (e) {
      throw StorageFailure(
        'No se pudo acceder al archivo solicitado.',
        cause: e,
      );
    }
  }

  /// Elimina un archivo relativo si existe. No hace nada si el path es vacío
  /// o el archivo no existe (evita borrar la raíz de `app_documents`).
  Future<void> deleteRelativeFile(String relativePath) async {
    if (relativePath.trim().isEmpty) return;
    try {
      final file = await resolveRelativeFile(relativePath);
      if (await file.exists()) {
        await file.delete();
      }
    } catch (e) {
      throw StorageFailure(
        'No se pudieron eliminar las fotos del vehículo.',
        cause: e,
      );
    }
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

  Future<String> _saveFileInVehicleFolder({
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
      final relativePath = p.join('vehicles', vehicleId.toString(), subfolder, newFileName);
      final targetPath = p.join(vehicleDir.path, subfolder, newFileName);

      await sourceFile.copy(targetPath);
      return relativePath;
    } catch (e) {
      throw StorageFailure(
        'Error al guardar el archivo en el dispositivo.',
        cause: e,
      );
    }
  }
}
