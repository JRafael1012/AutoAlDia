import 'models/vehicle_profile.dart';

/// Validadores de vehículo (reglas puras, sin dependencias externas).
///
/// Cada método devuelve `null` si el campo es válido o un mensaje amigable
/// en español listo para mostrar en la UI.
class VehicleValidator {
  const VehicleValidator();

  static const int maxBrandLength = 80;
  static const int maxModelLength = 80;
  static const int maxPlateLength = 20;

  String? validateBrand(String? value) {
    final v = value?.trim() ?? '';
    if (v.isEmpty) return 'Ingresa la marca del vehículo.';
    if (v.length > maxBrandLength) {
      return 'La marca no puede superar $maxBrandLength caracteres.';
    }
    return null;
  }

  String? validateModel(String? value) {
    final v = value?.trim() ?? '';
    if (v.isEmpty) return 'Ingresa el modelo del vehículo.';
    if (v.length > maxModelLength) {
      return 'El modelo no puede superar $maxModelLength caracteres.';
    }
    return null;
  }

  String? validateYear(String? value) {
    final v = value?.trim() ?? '';
    if (v.isEmpty) return null; // Opcional
    final parsed = int.tryParse(v);
    if (parsed == null) return 'El año debe ser un número.';
    final now = DateTime.now().year;
    if (parsed < 1900 || parsed > now + 1) {
      return 'El año debe estar entre 1900 y ${now + 1}.';
    }
    return null;
  }

  String? validatePlate(String? value) {
    final v = value?.trim() ?? '';
    if (v.isEmpty) return null; // Opcional
    if (v.length > maxPlateLength) {
      return 'La placa no puede superar $maxPlateLength caracteres.';
    }
    return null;
  }

  String? validateOdometer(String? value) {
    final v = value?.trim() ?? '';
    if (v.isEmpty) return 'Ingresa el kilometraje actual.';
    final parsed = double.tryParse(v);
    if (parsed == null) return 'El kilometraje debe ser un número.';
    if (parsed < 0) return 'El kilometraje no puede ser negativo.';
    return null;
  }

  String? validateFuelType(String? value) {
    if (value == null || value.isEmpty) return 'Selecciona el tipo de combustible.';
    if (!VehicleProfile.fuelTypes.contains(value)) {
      return 'Tipo de combustible no válido.';
    }
    return null;
  }
}
