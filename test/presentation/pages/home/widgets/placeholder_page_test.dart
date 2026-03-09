import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_futter_project/common/app_colors.dart';
import 'package:test_futter_project/common/app_dimensions.dart';
import 'package:test_futter_project/common/app_text_styles.dart';
import 'package:test_futter_project/presentation/pages/home/widgets/placeholder_page.dart';
import 'package:test_futter_project/utils/l10n/l10n.dart';

void main() {
  setUp(() {
    // Set up localisation values for the test
    AppLocalisations.localisations = {
      'pages.comingSoon.title': 'Coming Soon',
      'pages.comingSoon.subtitle': 'This feature is not available yet.',
    };
  });

  group('PlaceholderPage', () {
    testWidgets('displays the hourglass icon', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: PlaceholderPage()));

      final iconFinder = find.byIcon(Icons.hourglass_empty);
      expect(iconFinder, findsOneWidget);

      final iconWidget = tester.widget<Icon>(iconFinder);
      expect(iconWidget.size, AppDimensions.placeholderPageIconSize);
      expect(iconWidget.color, Colors.grey);
    });

    testWidgets('displays the correct title and subtitle', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: PlaceholderPage()));

      expect(find.text(AppLocalisations.comingSoonPlaceholderPageTitle), findsOneWidget);
      expect(find.text(AppLocalisations.comingSoonPlaceholderPageSubTitle), findsOneWidget);
    });

    testWidgets('uses correct text styles', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: PlaceholderPage()));

      final titleText = tester.widget<Text>(
        find.text(AppLocalisations.comingSoonPlaceholderPageTitle),
      );
      expect(titleText.style?.fontSize, AppTextStyles.zonaPro24.fontSize);
      expect(titleText.style?.fontWeight, AppTextStyles.zonaPro24.fontWeight);

      final subtitleText = tester.widget<Text>(
        find.text(AppLocalisations.comingSoonPlaceholderPageSubTitle),
      );
      expect(subtitleText.style?.fontSize, AppTextStyles.zonaPro16.fontSize);
      expect(subtitleText.style?.fontWeight, AppTextStyles.zonaPro16.fontWeight);
      expect(subtitleText.style?.color, Colors.grey);
      expect(subtitleText.textAlign, TextAlign.center);
    });

    testWidgets('has correct background color', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: PlaceholderPage()));

      final scaffold = tester.widget<Scaffold>(find.byType(Scaffold));
      expect(scaffold.backgroundColor, AppColors.scaffoldColor);
    });
  });
}
