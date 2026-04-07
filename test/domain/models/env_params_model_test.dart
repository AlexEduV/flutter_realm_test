import 'package:flutter_test/flutter_test.dart';
import 'package:test_futter_project/domain/models/env_params_model.dart';

void main() {
  group('EnvParamsModel', () {
    test('should create model with provided key and fallbackValue', () {
      // Arrange
      const key = 'API_KEY';
      const fallbackValue = 'default_value';

      // Act
      final model = EnvParamsModel(key: key, fallbackValue: fallbackValue);

      // Assert
      expect(model.key, key);
      expect(model.fallbackValue, fallbackValue);
    });

    test('should use empty string as default fallbackValue', () {
      // Arrange
      const key = 'API_KEY';

      // Act
      final model = EnvParamsModel(key: key);

      // Assert
      expect(model.key, key);
      expect(model.fallbackValue, '');
    });
  });
}
