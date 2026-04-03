import 'package:flutter_test/flutter_test.dart';
import 'package:test_futter_project/domain/entities/car_auto_complete_entity.dart';

void main() {
  group('CarAutoCompleteEntity', () {
    test('should create entity with given values', () {
      // Arrange
      const manufacturerId = 1;
      const manufacturer = 'Toyota';
      final models = ['Corolla', 'Camry'];

      // Act
      final entity = CarAutoCompleteEntity(
        manufacturerId: manufacturerId,
        manufacturer: manufacturer,
        models: models,
      );

      // Assert
      expect(entity.manufacturerId, manufacturerId);
      expect(entity.manufacturer, manufacturer);
      expect(entity.models, models);
    });

    test('should create entity from valid JSON', () {
      // Arrange
      final json = {
        'id': 2,
        'name': 'Honda',
        'models': ['Civic', 'Accord'],
      };

      // Act
      final entity = CarAutoCompleteEntity.fromJson(json);

      // Assert
      expect(entity.manufacturerId, 2);
      expect(entity.manufacturer, 'Honda');
      expect(entity.models, ['Civic', 'Accord']);
    });

    test('should handle empty models list in JSON', () {
      // Arrange
      final json = {'id': 3, 'name': 'Ford', 'models': []};

      // Act
      final entity = CarAutoCompleteEntity.fromJson(json);

      // Assert
      expect(entity.manufacturerId, 3);
      expect(entity.manufacturer, 'Ford');
      expect(entity.models, isEmpty);
    });

    test('should throw if JSON is missing required fields', () {
      // Arrange
      final jsonMissingId = {
        'name': 'BMW',
        'models': ['X5'],
      };
      final jsonMissingName = {
        'id': 4,
        'models': ['X5'],
      };
      final jsonMissingModels = {'id': 4, 'name': 'BMW'};

      // Act & Assert
      expect(() => CarAutoCompleteEntity.fromJson(jsonMissingId), throwsA(isA<TypeError>()));
      expect(() => CarAutoCompleteEntity.fromJson(jsonMissingName), throwsA(isA<TypeError>()));
      expect(() => CarAutoCompleteEntity.fromJson(jsonMissingModels), throwsA(isA<TypeError>()));
    });
  });
}
