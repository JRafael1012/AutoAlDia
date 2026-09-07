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
  static const int maxColorLength = 40;
  static const int minVinLength = 5;
  static const int maxVinLength = 30;
  static const int maxVehicleTypeLength = 30;
  static const int maxObservationsLength = 500;

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

  String? validateTankCapacity(String? value) {
    final v = value?.trim() ?? '';
    if (v.isEmpty) return null; // Opcional
    final parsed = double.tryParse(v);
    if (parsed == null) return 'La capacidad del tanque debe ser un número.';
    if (parsed <= 0) return 'La capacidad del tanque debe ser mayor a cero.';
    return null;
  }

  String? validateAcquisitionDate(String? value) {
    final v = value?.trim() ?? '';
    if (v.isEmpty) return null; // Opcional
    final now = DateTime.now();
    final parsed = DateTime.tryParse(v);
    if (parsed == null) return 'La fecha de adquisición no es válida.';
    if (parsed.isAfter(now)) return 'La fecha no puede ser en el futuro.';
    return null;
  }

  /// Valida un monto monetario en enteros (unidad mínima de la moneda).
  String? validateMoneyValue(String? value, String fieldLabel) {
    final v = value?.trim() ?? '';
    if (v.isEmpty) return null; // Opcional
    final parsed = int.tryParse(v);
    if (parsed == null) return 'El $fieldLabel debe ser un número entero.';
    if (parsed < 0) return 'El $fieldLabel no puede ser negativo.';
    return null;
  }

  String? validatePurchaseValue(String? value) =>
      validateMoneyValue(value, 'valor de compra');

  String? validateCurrentEstimatedValue(String? value) =>
      validateMoneyValue(value, 'valor actual estimado');

  String? validateColor(String? value) {
    final v = value?.trim() ?? '';
    if (v.isEmpty) return null; // Opcional
    if (v.length > maxColorLength) {
      return 'El color no puede superar $maxColorLength caracteres.';
    }
    return null;
  }

  String? validateVin(String? value) {
    final v = value?.trim() ?? '';
    if (v.isEmpty) return null; // Opcional
    if (v.length < minVinLength) {
      return 'El VIN debe tener al menos $minVinLength caracteres.';
    }
    if (v.length > maxVinLength) {
      return 'El VIN no puede superar $maxVinLength caracteres.';
    }
    if (!RegExp(r'^[a-zA-Z0-9]+$').hasMatch(v)) {
      return 'El VIN solo puede contener letras y números.';
    }
    return null;
  }

  String? validateVehicleType(String? value) {
    final v = value?.trim() ?? '';
    if (v.isEmpty) return null; // Opcional
    if (!VehicleProfile.vehicleTypes.contains(v)) {
      return 'Tipo de vehículo no válido.';
    }
    return null;
  }

  String? validateObservations(String? value) {
    final v = value?.trim() ?? '';
    if (v.isEmpty) return null; // Opcional
    if (v.length > maxObservationsLength) {
      return 'Las observaciones no pueden superar $maxObservationsLength caracteres.';
    }
    return null;
  }
}
