import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_futter_project/common/app_text_styles.dart';

void main() {
  group('AppTextStyles', () {
    test('roboto16 is correct', () {
      expect(AppTextStyles.roboto16.fontSize, 16);
      expect(AppTextStyles.roboto16.fontWeight, FontWeight.w500);
    });

    test('roboto18 is correct', () {
      expect(AppTextStyles.roboto18.fontSize, 18);
      expect(AppTextStyles.roboto18.fontWeight, FontWeight.w500);
    });

    test('roboto20 is correct', () {
      expect(AppTextStyles.roboto20.fontSize, 20);
      expect(AppTextStyles.roboto20.fontWeight, FontWeight.w600);
    });

    test('roboto24 is correct', () {
      expect(AppTextStyles.roboto24.fontSize, 24);
      expect(AppTextStyles.roboto24.fontWeight, FontWeight.w600);
    });
  });
}
