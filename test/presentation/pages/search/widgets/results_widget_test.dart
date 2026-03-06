import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_futter_project/common/app_dimensions.dart';
import 'package:test_futter_project/common/app_text_styles.dart';
import 'package:test_futter_project/presentation/pages/search/widgets/results_widget.dart';
import 'package:test_futter_project/presentation/widgets/app_badge.dart';
import 'package:test_futter_project/utils/l10n.dart';

void main() {
  setUp(() {
    // Set up localisation values for the test
    AppLocalisations.localisations = {'pages.results.title': 'Results'};
  });

  group('ResultsWidget', () {
    testWidgets('displays the results text from localisation', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: ResultsWidget(results: '5')),
        ),
      );

      expect(find.text(AppLocalisations.results), findsOneWidget);
    });

    testWidgets('displays the badge with the correct value', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: ResultsWidget(results: '10')),
        ),
      );

      expect(find.byType(AppBadge), findsOneWidget);
      expect(find.text('10'), findsOneWidget);
    });

    testWidgets('uses correct text style for results', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: ResultsWidget(results: '3')),
        ),
      );

      final textWidget = tester.widget<Text>(find.text(AppLocalisations.results));
      expect(textWidget.style?.fontSize, AppTextStyles.zonaPro16.fontSize);
      expect(textWidget.style?.fontWeight, FontWeight.w600);
    });

    testWidgets('row has correct spacing', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: ResultsWidget(results: '7')),
        ),
      );

      final rowWidget = tester.widget<Row>(find.byType(Row));
      expect(rowWidget.spacing, AppDimensions.minorL);
    });
  });
}
