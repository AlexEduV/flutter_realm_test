import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_flutter_project/presentation/features/search/widgets/search_filter_button.dart';

void main() {
  group('SearchFilterButton', () {
    testWidgets('displays icon, title, and badge', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: SearchFilterButton(title: 'Filter', icon: Icons.filter_alt, selectionCount: 2),
        ),
      );

      expect(find.text('Filter'), findsOneWidget);
      expect(find.byIcon(Icons.filter_alt), findsOneWidget);
      expect(find.byType(AppBadge), findsOneWidget);
      expect(find.text('2'), findsOneWidget);
    });

    testWidgets('displays optional text when provided', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: SearchFilterButton(
            title: 'Filter',
            icon: Icons.filter_alt,
            selectionCount: 1,
            text: 'Selected',
          ),
        ),
      );

      expect(find.text('Selected'), findsOneWidget);
    });

    testWidgets('does not display optional text when not provided', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: SearchFilterButton(title: 'Filter', icon: Icons.filter_alt, selectionCount: 0),
        ),
      );

      expect(find.text('Filter'), findsOneWidget);
      // Should not find any text widget with 'Selected'
      expect(find.text('Selected'), findsNothing);
    });

    testWidgets('calls onPressed when tapped', (WidgetTester tester) async {
      bool tapped = false;
      await tester.pumpWidget(
        MaterialApp(
          home: SearchFilterButton(
            title: 'Filter',
            icon: Icons.filter_alt,
            selectionCount: 3,
            onPressed: () {
              tapped = true;
            },
          ),
        ),
      );

      await tester.tap(find.byType(SearchFilterButton));
      expect(tapped, isTrue);
    });

    testWidgets('applies placeholder style when isPlaceHolder is true', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: SearchFilterButton(
            title: 'Filter',
            icon: Icons.filter_alt,
            selectionCount: 1,
            text: 'Placeholder',
            isPlaceHolder: true,
          ),
        ),
      );

      final textWidget = tester.widget<Text>(find.text('Placeholder'));
      expect(textWidget.style?.color, Colors.grey);
    });

    testWidgets('icon container has correct size and color', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: SearchFilterButton(
            title: 'Filter',
            icon: Icons.filter_alt,
            selectionCount: 1,
            iconSize: 50.0,
          ),
        ),
      );

      final container = tester.widget<Container>(
        find
            .descendant(of: find.byType(SearchFilterButton), matching: find.byType(Container))
            .first,
      );

      expect(container.constraints?.maxHeight, 50.0);
      expect(container.constraints?.maxWidth, 50.0);
      expect((container.decoration as BoxDecoration).color, AppColors.scaffoldColor);
    });
  });
}
