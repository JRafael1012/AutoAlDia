import '../errors/app_failure.dart';

/// Interfaz abstracta del repositorio de seguridad (PIN, biometría).
///
/// La interfaz vive en `core/security` sin depender de `flutter_secure_storage`
/// ni `local_auth`; la implementación concreta es la que usa esas librerías.
/// Esto permite inyectar un doble falso en pruebas unitarias (ver tests).
abstract interface class SecurityRepository {
  /// true si el usuario ya definió un PIN.
  Future<bool> hasPin();

  /// Guarda un PIN nuevo (hash + salt en almacenamiento seguro).
  /// Lanza [SecurityFailure] si falla la escritura.
  Future<void> setPin(String pin);

  /// Verifica un PIN contra el hash almacenado.
  /// true si coincide, false si no; lanza [SecurityFailure] si hay error.
  Future<bool> validatePin(String pin);

  /// Elimina el PIN almacenado.
  Future<void> clearPin();

  /// true si el dispositivo soporta autenticación biométrica.
  Future<bool> isBiometricAvailable();

  /// true si el usuario habilitó la biometría en la configuración de la app.
  Future<bool> isBiometricEnabled();

  Future<void> setBiometricEnabled(bool enabled);

  /// Lanza la autenticación biométrica nativa del dispositivo.
  /// [localizedReason] es el mensaje que el SO muestra al usuario.
  Future<bool> authenticateWithBiometrics({required String localizedReason});
}