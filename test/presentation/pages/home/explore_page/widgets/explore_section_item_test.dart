import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_futter_project/common/app_colors.dart';
import 'package:test_futter_project/common/app_dimensions.dart';
import 'package:test_futter_project/presentation/pages/home/explore_page/widgets/explore_section_item.dart';

void main() {
  group('ExploreSectionItem', () {
    testWidgets('has default height and width', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: Scaffold(body: ExploreSectionItem())));

      final containerFinder = find.byType(Container);
      final size = tester.getSize(containerFinder);
      expect(size.height, 120.0);
      expect(size.width, 120.0);
    });

    testWidgets('uses custom height when provided', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: ExploreSectionItem(height: 200.0))),
      );

      final containerFinder = find.byType(Container);
      final size = tester.getSize(containerFinder);
      expect(size.height, 200.0);
      expect(size.width, 120.0);
    });

    testWidgets('has correct color and border radius', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: Scaffold(body: ExploreSectionItem())));

      final containerWidget = tester.widget<Container>(find.byType(Container));
      final decoration = containerWidget.decoration as BoxDecoration;

      expect(decoration.color, AppColors.placeholderColor);
      expect(decoration.borderRadius, BorderRadius.circular(AppDimensions.normalS));
    });
  });
}
