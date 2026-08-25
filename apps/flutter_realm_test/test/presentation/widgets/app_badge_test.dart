import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppBadge', () {
    testWidgets('displays the correct text', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: Scaffold(body: AppBadge(count: 5))));

      expect(find.text('5'), findsOneWidget);
    });

    testWidgets('has circular shape and black background', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: Scaffold(body: AppBadge(count: 1))));

      final container = tester.widget<Container>(find.byType(Container));
      final decoration = container.decoration as BoxDecoration;

      expect(decoration.shape, BoxShape.circle);
      expect(decoration.color, Colors.black);
    });

    testWidgets('uses correct text style', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: Scaffold(body: AppBadge(count: 10))));

      final textWidget = tester.widget<Text>(find.text('10'));
      final expectedStyle = AppTextStyles.zonaPro16.copyWith(color: Colors.white);

      expect(textWidget.style?.fontSize, expectedStyle.fontSize);
      expect(textWidget.style?.fontWeight, FontWeight.w600);
      expect(textWidget.style?.color, expectedStyle.color);
    });

    testWidgets('is centered and fits text', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: Scaffold(body: AppBadge(count: 999))));

      final fittedBox = find.byType(FittedBox);
      expect(fittedBox, findsOneWidget);

      final container = tester.widget<Container>(find.byType(Container));
      expect(container.alignment, Alignment.center);
    });
  });
}
