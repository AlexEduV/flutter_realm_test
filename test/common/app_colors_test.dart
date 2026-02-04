import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_futter_project/common/app_colors.dart';

void main() {
  group('AppColors', () {
    test('mainThemeColor should be Colors.indigo', () {
      expect(AppColors.mainThemeColor, Colors.indigo);
    });

    test('placeholderColor should be Colors.grey[400]', () {
      expect(AppColors.placeholderColor, Colors.grey[400]);
    });

    test('headerColor should be Color(0xFF181C2A)', () {
      expect(AppColors.headerColor, const Color(0xFF181C2A));
    });

    test('accentColor should be Color(0xFF9A9A9A)', () {
      expect(AppColors.accentColor, const Color(0xFF9A9A9A));
    });

    test('scaffoldColor should be Color(0xFFE9E9ED)', () {
      expect(AppColors.scaffoldColor, const Color(0xFFE9E9ED));
    });

    test('all colors should be of type Color', () {
      expect(AppColors.mainThemeColor, isA<Color>());
      expect(AppColors.placeholderColor, isA<Color>());
      expect(AppColors.headerColor, isA<Color>());
      expect(AppColors.accentColor, isA<Color>());
      expect(AppColors.scaffoldColor, isA<Color>());
    });
  });
}
