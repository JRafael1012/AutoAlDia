import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/database/app_database_provider.dart';
import '../../../../core/errors/app_failure.dart';
import '../../../../core/security/security_providers.dart';
import '../../data/auth_repository_impl.dart';
import '../../domain/models/user_profile.dart';
import '../../domain/repository.dart';

part 'auth_providers.g.dart';

/// Repositorio de perfil basado en la base de datos local.
@Riverpod(keepAlive: true)
AuthRepository authRepository(Ref ref) {
  return AuthRepositoryImpl(ref.watch(appDatabaseProvider));
}

/// Sesión del perfil local (null = aún no hay perfil creado).
@Riverpod(keepAlive: true)
class ProfileController extends _$ProfileController {
  @override
  Future<UserProfile?> build() {
    return ref.watch(authRepositoryProvider).getProfile();
  }

  Future<void> createProfile({
    required String name,
    String? email,
    String? phone,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref
          .read(authRepositoryProvider)
          .createProfile(name: name, email: email, phone: phone),
    );
  }

  Future<void> reload() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(authRepositoryProvider).getProfile(),
    );
  }
}

/// true si el usuario ya definió un PIN en esta instalación.
@Riverpod(keepAlive: true)
class HasPinController extends _$HasPinController {
  @override
  Future<bool> build() async {
    return ref.watch(securityRepositoryProvider).hasPin();
  }

  Future<void> reload() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(securityRepositoryProvider).hasPin(),
    );
  }
}

/// Estado de desbloqueo de la sesión actual (PIN validado o no).
///
/// Decisión: es estado de sesión en memoria (se reinicia al cerrar la app),
/// no persistido. El PIN validado queda como `unlocked` solo para esta sesión.
@Riverpod(keepAlive: true)
class PinUnlockController extends _$PinUnlockController {
  @override
  bool build() => false;

  bool get unlocked => state;

  Future<bool> unlockWithPin(String pin) async {
    final ok = await ref.read(securityRepositoryProvider).validatePin(pin);
    if (!ok) {
      throw const SecurityFailure('El PIN no es correcto. Verifica e intenta de nuevo.');
    }
    state = true;
    return true;
  }

  Future<bool> unlockWithBiometrics() async {
    final ok = await ref
        .read(securityRepositoryProvider)
        .authenticateWithBiometrics(localizedReason: 'Desbloquea AutoAlDía para continuar.');
    if (!ok) {
      throw const SecurityFailure('No se pudo autenticar con biometría.');
    }
    state = true;
    return true;
  }

  /// Marca la sesión como desbloqueada (p. ej. justo después de configurar el PIN).
  void markUnlocked() => state = true;

  void lock() => state = false;
}

/// true si el usuario habilitó la biometría en la configuración.
@Riverpod(keepAlive: true)
class BiometricsEnabledController extends _$BiometricsEnabledController {
  @override
  Future<bool> build() {
    return ref.watch(securityRepositoryProvider).isBiometricEnabled();
  }

  Future<void> reload() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(securityRepositoryProvider).isBiometricEnabled(),
    );
  }
}