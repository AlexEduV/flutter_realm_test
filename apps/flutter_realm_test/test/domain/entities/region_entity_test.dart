import 'package:flutter_test/flutter_test.dart';
import 'package:test_flutter_project/domain/entities/region_entity.dart';

void main() {
  group('RegionEntity', () {
    test('constructor assigns locale correctly', () {
      const region = RegionEntity(locale: 'US');
      expect(region.locale, 'US');
    });

    test('fromJson creates correct RegionEntity', () {
      final json = {'code': 'DE'};
      final region = RegionEntity.fromJson(json);
      expect(region.locale, 'DE');
    });

    test('equality and hashCode: identical objects', () {
      const r1 = RegionEntity(locale: 'FR');
      const r2 = RegionEntity(locale: 'FR');
      expect(r1, r2);
      expect(r1.hashCode, r2.hashCode);
    });

    test('equality and hashCode: different objects', () {
      const r1 = RegionEntity(locale: 'FR');
      const r2 = RegionEntity(locale: 'IT');
      expect(r1 == r2, isFalse);
      expect(r1.hashCode == r2.hashCode, isFalse);
    });
  });
}
