import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_futter_project/common/constants/app_colors.dart';

void main() {
  group('AppColors', () {
    test('mainThemeColor is Colors.indigo', () {
      expect(AppColors.mainThemeColor, Colors.indigo);
    });

    test('lightGrey is Colors.grey[300]', () {
      expect(AppColors.lightGrey, Colors.grey[300]);
    });

    test('placeholderColor is Colors.grey[400]', () {
      expect(AppColors.placeholderColor, Colors.grey[400]);
    });

    test('placeholderColorDark is Colors.grey[700]', () {
      expect(AppColors.placeholderColorDark, Colors.grey[700]);
    });

    test('headerColor is Color(0xFF181C2A)', () {
      expect(AppColors.headerColor, const Color(0xFF181C2A));
    });

    test('accentColor is Color(0xFF9A9A9A)', () {
      expect(AppColors.accentColor, const Color(0xFF9A9A9A));
    });

    test('scaffoldColor is Color(0xFFE9E9ED)', () {
      expect(AppColors.scaffoldColor, const Color(0xFFE9E9ED));
    });

    test('gold is Color(0xFFFFD700)', () {
      expect(AppColors.gold, const Color(0xFFFFD700));
    });

    test('mutedGold is Color(0xFFCCAC00)', () {
      expect(AppColors.mutedGold, const Color(0xFFCCAC00));
    });

    test('cherryRed is Color(0xff7b2d26)', () {
      expect(AppColors.cherryRed, const Color(0xff7b2d26));
    });

    test('teal is Color(0xff2e959e)', () {
      expect(AppColors.teal, const Color(0xff2e959e));
    });
  });
}
