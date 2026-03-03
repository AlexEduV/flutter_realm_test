import 'package:flutter_test/flutter_test.dart';
import 'package:test_futter_project/common/app_dimensions.dart';

void main() {
  group('AppDimensions', () {
    test('contentPadding should be 12.0', () {
      expect(AppDimensions.contentPadding, 12.0);
    });

    test('normalXL should be 24.0', () {
      expect(AppDimensions.normalXL, 24.0);
    });

    test('normalL should be 18.0', () {
      expect(AppDimensions.normalL, 18.0);
    });

    test('normalM should be 16.0', () {
      expect(AppDimensions.normalM, 16.0);
    });

    test('normalS should be 12.0', () {
      expect(AppDimensions.normalS, 12.0);
    });

    test('normalXS should be 10.0', () {
      expect(AppDimensions.normalXS, 10.0);
    });

    test('minorL should be 8.0', () {
      expect(AppDimensions.minorL, 8.0);
    });

    test('minorM should be 6.0', () {
      expect(AppDimensions.minorM, 6.0);
    });

    test('minorS should be 4.0', () {
      expect(AppDimensions.minorS, 4.0);
    });

    test('appBarIconSize should be 32.0', () {
      expect(AppDimensions.appBarIconSize, 32.0 / 1.2);
    });

    test('bottomAppBarIconEnlargedSize should be 36.0', () {
      expect(AppDimensions.bottomAppBarIconEnlargedSize, 36.0);
    });

    test('bottomAppBarIconSize should be 24.0', () {
      expect(AppDimensions.bottomAppBarIconSize, 24.0);
    });

    test('placeholderPageIconSize should be 64.0', () {
      expect(AppDimensions.placeholderPageIconSize, 64.0);
    });

    test('all dimensions should be of type double', () {
      expect(AppDimensions.contentPadding, isA<double>());
      expect(AppDimensions.normalXL, isA<double>());
      expect(AppDimensions.normalL, isA<double>());
      expect(AppDimensions.normalM, isA<double>());
      expect(AppDimensions.normalS, isA<double>());
      expect(AppDimensions.normalXS, isA<double>());
      expect(AppDimensions.minorL, isA<double>());
      expect(AppDimensions.minorM, isA<double>());
      expect(AppDimensions.minorS, isA<double>());
      expect(AppDimensions.appBarIconSize, isA<double>());
      expect(AppDimensions.bottomAppBarIconEnlargedSize, isA<double>());
      expect(AppDimensions.bottomAppBarIconSize, isA<double>());
      expect(AppDimensions.placeholderPageIconSize, isA<double>());
    });
  });
}
