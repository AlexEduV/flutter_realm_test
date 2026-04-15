import 'package:flutter_test/flutter_test.dart';
import 'package:test_flutter_project/domain/models/region_ui_model.dart';

void main() {
  group('RegionUiModel', () {
    test('should assign properties via constructor', () {
      const model = RegionUiModel(countryName: 'France', code: 'FR');
      expect(model.countryName, 'France');
      expect(model.code, 'FR');
    });

    test('should be equal if countryName and code are the same', () {
      const model1 = RegionUiModel(countryName: 'France', code: 'FR');
      const model2 = RegionUiModel(countryName: 'France', code: 'FR');
      expect(model1, model2);
      expect(model1.hashCode, model2.hashCode);
    });

    test('should not be equal if countryName is different', () {
      const model1 = RegionUiModel(countryName: 'France', code: 'FR');
      const model2 = RegionUiModel(countryName: 'Germany', code: 'FR');
      expect(model1 == model2, isFalse);
    });

    test('should not be equal if code is different', () {
      const model1 = RegionUiModel(countryName: 'France', code: 'FR');
      const model2 = RegionUiModel(countryName: 'France', code: 'DE');
      expect(model1 == model2, isFalse);
    });

    test('should be identical to itself', () {
      const model = RegionUiModel(countryName: 'France', code: 'FR');
      expect(identical(model, model), isTrue);
      expect(model == model, isTrue);
    });
  });
}
