import 'package:autoaldia/features/auth/domain/profile_validator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const validator = ProfileValidator();

  group('ProfileValidator', () {
    test('validateName valida presencia y longitud', () {
      expect(validator.validateName(null), isNotNull);
      expect(validator.validateName('   '), isNotNull);
      expect(validator.validateName('A' * 121), isNotNull);
      expect(validator.validateName('Carlos Mendoza'), isNull);
    });

    test('validateEmail valida formato si se ingresa', () {
      expect(validator.validateEmail(null), isNull); // Es opcional
      expect(validator.validateEmail(''), isNull);
      expect(validator.validateEmail('invalido'), isNotNull);
      expect(validator.validateEmail('usuario@correo.com'), isNull);
    });

    test('validatePin valida 4 a 6 digitos numéricos', () {
      expect(validator.validatePin('123'), isNotNull);
      expect(validator.validatePin('1234567'), isNotNull);
      expect(validator.validatePin('12ab'), isNotNull);
      expect(validator.validatePin('1234'), isNull);
      expect(validator.validatePin('123456'), isNull);
    });

    test('validatePinConfirmation compara con el pin esperado', () {
      expect(validator.validatePinConfirmation('1234', '1234'), isNull);
      expect(validator.validatePinConfirmation('1234', '5678'), isNotNull);
    });
  });
}
