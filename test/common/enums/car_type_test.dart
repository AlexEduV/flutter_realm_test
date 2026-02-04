import 'package:flutter_test/flutter_test.dart';
import 'package:test_futter_project/common/enums/car_type.dart';

void main() {
  group('CarType enum', () {
    test('should contain all expected values', () {
      expect(CarType.values.length, 3);
      expect(CarType.values, contains(CarType.car));
      expect(CarType.values, contains(CarType.bike));
      expect(CarType.values, contains(CarType.truck));
    });

    test('should have correct index for each value', () {
      expect(CarType.car.index, 0);
      expect(CarType.bike.index, 1);
      expect(CarType.truck.index, 2);
    });

    test('should have correct string representation', () {
      expect(CarType.car.toString(), 'CarType.car');
      expect(CarType.bike.toString(), 'CarType.bike');
      expect(CarType.truck.toString(), 'CarType.truck');
    });
  });
}
