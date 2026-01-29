import 'package:flutter_test/flutter_test.dart';
import 'package:test_futter_project/common/app_dimensions.dart';

void main() {
  group('AppDimensions', () {
    test('contentPadding is correct', () {
      expect(AppDimensions.contentPadding, 12.0);
    });

    test('normalM is correct', () {
      expect(AppDimensions.normalL, 18.0);
    });

    test('normalS is correct', () {
      expect(AppDimensions.normalS, 14.0);
    });

    test('minorL is correct', () {
      expect(AppDimensions.minorL, 8.0);
    });

    test('minorM is correct', () {
      expect(AppDimensions.minorM, 6.0);
    });

    test('minorS is correct', () {
      expect(AppDimensions.minorS, 4.0);
    });
  });
}
