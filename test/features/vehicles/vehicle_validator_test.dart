import 'package:autoaldia/features/vehicles/domain/vehicle_validator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const validator = VehicleValidator();

  group('VehicleValidator', () {
    test('validateBrand rechaza marcas vacías o demasiado largas', () {
      expect(validator.validateBrand(null), isNotNull);
      expect(validator.validateBrand('  '), isNotNull);
      expect(validator.validateBrand('A' * 81), isNotNull);
      expect(validator.validateBrand('Toyota'), isNull);
    });

    test('validateModel rechaza modelos vacíos', () {
      expect(validator.validateModel(''), isNotNull);
      expect(validator.validateModel('Corolla'), isNull);
    });

    test('validateYear valida rango de años lógicos', () {
      expect(validator.validateYear('abc'), isNotNull);
      expect(validator.validateYear('1899'), isNotNull);
      expect(validator.validateYear('2020'), isNull);
      expect(validator.validateYear(null), isNull); // Es opcional
    });

    test('validateOdometer rechaza valores negativos o no numéricos', () {
      expect(validator.validateOdometer(''), isNotNull);
      expect(validator.validateOdometer('-50'), isNotNull);
      expect(validator.validateOdometer('45000.5'), isNull);
    });

    test('validateFuelType valida tipos permitidos', () {
      expect(validator.validateFuelType('invalido'), isNotNull);
      expect(validator.validateFuelType('gasolina'), isNull);
      expect(validator.validateFuelType('diesel'), isNull);
      expect(validator.validateFuelType('electrico'), isNull);
      expect(validator.validateFuelType('hibrido'), isNull);
    });
  });
}
