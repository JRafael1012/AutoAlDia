import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:local_auth/local_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'secure_security_repository.dart';
import 'security_repository.dart';

part 'security_providers.g.dart';

/// Proveedor del repositorio de seguridad (PIN + biometría).
///
/// Dependencias inyectadas de forma directa: no usamos otro provider por ser
/// objetos sin ciclo de vida propios (FlutterSecureStorage y LocalAuthentication
/// son stateless; se instancian de nuevo sin costo real).
@Riverpod(keepAlive: true)
SecurityRepository securityRepository(Ref ref) {
  return SecureSecurityRepository(
    const FlutterSecureStorage(),
    LocalAuthentication(),
  );
}