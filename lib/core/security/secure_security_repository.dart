import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:local_auth/local_auth.dart';

import '../errors/app_failure.dart';
import 'security_repository.dart';

/// Implementación de seguridad real usando [FlutterSecureStorage] (PIN) y
/// [LocalAuthentication] (biometría).
///
/// Decisión de diseño: el PIN se guarda como **SHA-256(salt + pin)**, nunca en
/// texto plano. El salt (aleatorio, 16 bytes) se almacena en el mismo key-store.
/// Ver ARQUITECTURA.md — ajuste 5.4.
class SecureSecurityRepository implements SecurityRepository {
  SecureSecurityRepository(this._storage, this._localAuth);

  final FlutterSecureStorage _storage;
  final LocalAuthentication _localAuth;

  // ── PIN ──────────────────────────────────────────────────────────────────

  static const _keyHash = 'pin_hash';
  static const _keySalt = 'pin_salt';
  static const _keyBiometric = 'biometric_enabled';

  @override
  Future<bool> hasPin() async {
    try {
      return await _storage.read(key: _keyHash) != null;
    } catch (e) {
      throw SecurityFailure(
        'No se pudo verificar si existe un PIN configurado.',
        cause: e,
      );
    }
  }

  @override
  Future<void> setPin(String pin) async {
    try {
      final salt = _generateSalt();
      final hash = _hashPin(pin, salt);
      await Future.wait([
        _storage.write(key: _keySalt, value: salt),
        _storage.write(key: _keyHash, value: hash),
      ]);
    } catch (e) {
      throw SecurityFailure(
        'No se pudo guardar el PIN. Intenta de nuevo.',
        cause: e,
      );
    }
  }

  @override
  Future<bool> validatePin(String pin) async {
    try {
      final salt = await _storage.read(key: _keySalt);
      final storedHash = await _storage.read(key: _keyHash);
      if (salt == null || storedHash == null) return false;
      return _hashPin(pin, salt) == storedHash;
    } catch (e) {
      throw SecurityFailure(
        'No se pudo validar el PIN. Intenta de nuevo.',
        cause: e,
      );
    }
  }

  @override
  Future<void> clearPin() async {
    try {
      await Future.wait([
        _storage.delete(key: _keySalt),
        _storage.delete(key: _keyHash),
      ]);
    } catch (e) {
      throw SecurityFailure(
        'No se pudo eliminar el PIN configurado.',
        cause: e,
      );
    }
  }

  // ── BIOMETRÍA ───────────────────────────────────────────────────────────

  @override
  Future<bool> isBiometricAvailable() async {
    try {
      return await _localAuth.canCheckBiometrics;
    } catch (e) {
      throw SecurityFailure(
        'No se pudo determinar si la biometría está disponible.',
        cause: e,
      );
    }
  }

  @override
  Future<bool> isBiometricEnabled() async {
    try {
      final value = await _storage.read(key: _keyBiometric);
      return value == 'true';
    } catch (e) {
      throw SecurityFailure(
        'No se pudo leer la configuración de biometría.',
        cause: e,
      );
    }
  }

  @override
  Future<void> setBiometricEnabled(bool enabled) async {
    try {
      await _storage.write(key: _keyBiometric, value: enabled.toString());
    } catch (e) {
      throw SecurityFailure(
        'No se pudo guardar la configuración de biometría.',
        cause: e,
      );
    }
  }

  @override
  Future<bool> authenticateWithBiometrics({required String localizedReason}) async {
    try {
      if (!await isBiometricAvailable()) {
        throw SecurityFailure(
          'La autenticación biométrica no está disponible en este dispositivo.',
        );
      }
      return await _localAuth.authenticate(
        localizedReason: localizedReason,
        biometricOnly: true,
        persistAcrossBackgrounding: true,
      );
    } on SecurityFailure {
      rethrow;
    } catch (e) {
      throw SecurityFailure(
        'No se pudo completar la autenticación biométrica.',
        cause: e,
      );
    }
  }

  // ── UTILIDADES ───────────────────────────────────────────────────────────

  /// Genera un salt de 16 bytes aleatorios seguros (no predecible).
  static String _generateSalt() {
    final random = Random.secure();
    final saltBytes = Uint8List.fromList(
      List.generate(16, (_) => random.nextInt(256)),
    );
    return base64UrlEncode(saltBytes);
  }

  /// Hash SHA-256 de "salt:pin" en hexadecimal. El resultado se persiste.
  static String _hashPin(String pin, String salt) {
    final bytes = utf8.encode('$salt:$pin');
    return sha256.convert(bytes).toString();
  }
}