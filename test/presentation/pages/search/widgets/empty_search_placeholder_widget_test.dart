import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_futter_project/common/app_dimensions.dart';
import 'package:test_futter_project/common/app_text_styles.dart';
import 'package:test_futter_project/presentation/pages/search/widgets/empty_search_placeholder_widget.dart';
import 'package:test_futter_project/utils/l10n.dart';

void main() {
  setUp(() {
    // Set up localisation values for the test
    AppLocalisations.localisations = {
      'pages.search.emptyPlaceholder': 'No results were found for this search.',
    };
  });

  group('EmptySearchPlaceholderWidget', () {
    testWidgets('displays the correct placeholder text', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: EmptySearchPlaceholderWidget())),
      );

      expect(find.text(AppLocalisations.emptySearchPlaceholderText), findsOneWidget);
    });

    testWidgets('uses correct text style and maxLines', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: EmptySearchPlaceholderWidget())),
      );

      final textWidget = tester.widget<Text>(
        find.text(AppLocalisations.emptySearchPlaceholderText),
      );
      expect(textWidget.style?.fontSize, AppTextStyles.zonaPro18.fontSize);
      expect(textWidget.style?.fontWeight, AppTextStyles.zonaPro18.fontWeight);
      expect(textWidget.maxLines, 3);
    });

    testWidgets('applies correct padding', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: EmptySearchPlaceholderWidget())),
      );

      final paddingWidget = tester.widget<Padding>(find.byType(Padding));
      expect(paddingWidget.padding, const EdgeInsets.all(AppDimensions.normalL));
    });

    testWidgets('uses Flexible inside Row', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: EmptySearchPlaceholderWidget())),
      );

      final rowFinder = find.byType(Row);
      expect(rowFinder, findsOneWidget);

      final flexibleFinder = find.descendant(of: rowFinder, matching: find.byType(Flexible));
      expect(flexibleFinder, findsOneWidget);
    });
  });
}
