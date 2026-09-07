import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'local_storage_service.dart';

part 'storage_providers.g.dart';

/// Proveedor del servicio de almacenamiento físico de archivos locales.
@Riverpod(keepAlive: true)
LocalStorageService localStorageService(Ref ref) {
  return LocalStorageService();
}
