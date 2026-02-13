import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_futter_project/common/app_text_styles.dart';

void main() {
  group('AppTextStyles', () {
    test('zonaPro16 should have fontSize 16 and FontWeight.w500', () {
      expect(AppTextStyles.zonaPro16.fontSize, 16);
      expect(AppTextStyles.zonaPro16.fontWeight, FontWeight.w500);
    });

    test('zonaPro18 should have fontSize 18 and FontWeight.w500', () {
      expect(AppTextStyles.zonaPro18.fontSize, 18);
      expect(AppTextStyles.zonaPro18.fontWeight, FontWeight.w500);
    });

    test('zonaPro20 should have fontSize 20 and FontWeight.w600', () {
      expect(AppTextStyles.zonaPro20.fontSize, 20);
      expect(AppTextStyles.zonaPro20.fontWeight, FontWeight.w600);
    });

    test('zonaPro24 should have fontSize 24 and FontWeight.w600', () {
      expect(AppTextStyles.zonaPro24.fontSize, 24);
      expect(AppTextStyles.zonaPro24.fontWeight, FontWeight.w600);
    });

    test('zonaPro30 should have fontSize 30 and FontWeight.w700', () {
      expect(AppTextStyles.zonaPro30.fontSize, 30);
      expect(AppTextStyles.zonaPro30.fontWeight, FontWeight.w700);
    });

    test('zonaPro30White should have fontSize 30, FontWeight.w700, and color white', () {
      expect(AppTextStyles.zonaPro30White.fontSize, 30);
      expect(AppTextStyles.zonaPro30White.fontWeight, FontWeight.w700);
      expect(AppTextStyles.zonaPro30White.color, Colors.white);
    });

    test('zonaPro24White should have fontSize 24, FontWeight.w600, and color white', () {
      expect(AppTextStyles.zonaPro24White.fontSize, 24);
      expect(AppTextStyles.zonaPro24White.fontWeight, FontWeight.w600);
      expect(AppTextStyles.zonaPro24White.color, Colors.white);
    });

    test('zonaPro16Grey should have fontSize 16, FontWeight.w500, and color grey[700]', () {
      expect(AppTextStyles.zonaPro16Grey.fontSize, 16);
      expect(AppTextStyles.zonaPro16Grey.fontWeight, FontWeight.w500);
      expect(AppTextStyles.zonaPro16Grey.color, Colors.grey[700]);
    });

    test('all styles should be of type TextStyle', () {
      expect(AppTextStyles.zonaPro16, isA<TextStyle>());
      expect(AppTextStyles.zonaPro18, isA<TextStyle>());
      expect(AppTextStyles.zonaPro20, isA<TextStyle>());
      expect(AppTextStyles.zonaPro24, isA<TextStyle>());
      expect(AppTextStyles.zonaPro30, isA<TextStyle>());
      expect(AppTextStyles.zonaPro30White, isA<TextStyle>());
      expect(AppTextStyles.zonaPro24White, isA<TextStyle>());
      expect(AppTextStyles.zonaPro16Grey, isA<TextStyle>());
    });
  });
}
