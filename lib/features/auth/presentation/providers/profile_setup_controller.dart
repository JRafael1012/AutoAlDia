import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/errors/app_failure.dart';
import '../../../../core/security/security_providers.dart';
import '../../domain/profile_validator.dart';
import 'auth_providers.dart';
import 'profile_setup_state.dart';

part 'profile_setup_controller.g.dart';

/// Controlador del formulario de creación de perfil.
///
/// Decisión: se usa un `Notifier` local a la pantalla (regla de Riverpod para
/// formularios), no `StateProvider` manuales. Mantiene todo el estado del
/// formulario + la lógica de envío en un solo lugar testeable.
@Riverpod(keepAlive: true)
class ProfileSetupController extends _$ProfileSetupController {
  static const _validator = ProfileValidator();

  @override
  ProfileSetupState build() => const ProfileSetupState();

  void setName(String value) => state = state.copyWith(name: value, errorMessage: null);
  void setEmail(String value) => state = state.copyWith(email: value, errorMessage: null);
  void setPhone(String value) => state = state.copyWith(phone: value, errorMessage: null);
  void setPinEnabled(bool value) =>
      state = state.copyWith(pinEnabled: value, biometricsEnabled: false, errorMessage: null);
  void setPin(String value) => state = state.copyWith(pin: value, errorMessage: null);
  void setPinConfirm(String value) => state = state.copyWith(pinConfirm: value, errorMessage: null);
  void setBiometricsEnabled(bool value) =>
      state = state.copyWith(biometricsEnabled: value, errorMessage: null);

  /// Valida y envía el formulario: crea el perfil, configura PIN y biometría.
  Future<bool> submit() async {
    final s = state;
    final nameError = _validator.validateName(s.name);
    final emailError = _validator.validateEmail(s.email);
    final pinError = s.pinEnabled ? _validator.validatePin(s.pin) : null;
    final pinConfirmError =
        s.pinEnabled ? _validator.validatePinConfirmation(s.pinConfirm, s.pin) : null;

    final firstError = nameError ?? emailError ?? pinError ?? pinConfirmError;
    if (firstError != null) {
      state = state.copyWith(errorMessage: firstError);
      return false;
    }

    if (s.pinEnabled && s.biometricsEnabled) {
      try {
        if (!await ref.read(securityRepositoryProvider).isBiometricAvailable()) {
          state = state.copyWith(
            errorMessage: 'Tu dispositivo no soporta autenticación biométrica.',
          );
          return false;
        }
      } on AppFailure catch (e) {
        state = state.copyWith(errorMessage: e.message);
        return false;
      }
    }

    state = state.copyWith(submitting: true, errorMessage: null);
    try {
      await ref.read(profileControllerProvider.notifier).createProfile(
            name: s.name,
            email: s.email.isEmpty ? null : s.email,
            phone: s.phone.isEmpty ? null : s.phone,
          );

      final security = ref.read(securityRepositoryProvider);
      if (s.pinEnabled) {
        await security.setPin(s.pin);
        if (s.biometricsEnabled) {
          // La biometría solo tiene sentido como desbloqueo del PIN.
          await security.setBiometricEnabled(true);
        }
      }

      // Esta sesión queda desbloqueada: el PIN se acaba de configurar.
      ref.read(pinUnlockControllerProvider.notifier).markUnlocked();
    } on AppFailure catch (e) {
      state = state.copyWith(submitting: false, errorMessage: e.message);
      return false;
    } catch (_) {
      state = state.copyWith(
        submitting: false,
        errorMessage: 'Ocurrió un error inesperado. Intenta de nuevo.',
      );
      return false;
    }

    state = state.copyWith(submitting: false, completed: true);
    return true;
  }
}