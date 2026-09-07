/// Validadores de perfil (reglas puras, sin dependencias externas).
///
/// Cada método devuelve `null` si el campo es válido o un mensaje amigable en
/// español listo para mostrar en la UI. No lanza excepciones.
class ProfileValidator {
  const ProfileValidator();

  static final RegExp _emailPattern = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
  static final RegExp _pinPattern = RegExp(r'^\d+$');

  static const int minPinLength = 4;
  static const int maxPinLength = 6;
  static const int maxNameLength = 120;

  String? validateName(String? value) {
    final v = value?.trim() ?? '';
    if (v.isEmpty) {
      return 'Ingresa tu nombre.';
    }
    if (v.length > maxNameLength) {
      return 'El nombre no puede superar $maxNameLength caracteres.';
    }
    return null;
  }

  /// El correo es opcional; si se ingresa, debe ser válido.
  String? validateEmail(String? value) {
    final v = value?.trim() ?? '';
    if (v.isEmpty) return null;
    if (!_emailPattern.hasMatch(v)) {
      return 'El correo no parece válido.';
    }
    return null;
  }

  String? validatePin(String? value) {
    final v = value?.trim() ?? '';
    if (v.length < minPinLength) {
      return 'El PIN debe tener al menos $minPinLength dígitos.';
    }
    if (v.length > maxPinLength) {
      return 'El PIN no puede superar $maxPinLength dígitos.';
    }
    if (!_pinPattern.hasMatch(v)) {
      return 'El PIN solo puede contener números.';
    }
    return null;
  }

  String? validatePinConfirmation(String? value, String? expected) {
    if (expected == null || expected.isEmpty) return null;
    if (value != expected) {
      return 'El PIN de confirmación no coincide.';
    }
    return null;
  }
}