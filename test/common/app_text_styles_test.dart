import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_futter_project/common/app_text_styles.dart';

void main() {
  group('AppTextStyles', () {
    test('zonaPro16 is correct', () {
      expect(AppTextStyles.zonaPro16.fontSize, 16);
      expect(AppTextStyles.zonaPro16.fontWeight, FontWeight.w500);
    });

    test('zonaPro18 is correct', () {
      expect(AppTextStyles.zonaPro18.fontSize, 18);
      expect(AppTextStyles.zonaPro18.fontWeight, FontWeight.w500);
    });

    test('zonaPro20 is correct', () {
      expect(AppTextStyles.zonaPro20.fontSize, 20);
      expect(AppTextStyles.zonaPro20.fontWeight, FontWeight.w600);
    });

    test('zonaPro24 is correct', () {
      expect(AppTextStyles.zonaPro24.fontSize, 24);
      expect(AppTextStyles.zonaPro24.fontWeight, FontWeight.w600);
    });
  });
}
