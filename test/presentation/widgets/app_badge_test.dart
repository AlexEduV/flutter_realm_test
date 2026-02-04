import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_futter_project/common/app_text_styles.dart';
import 'package:test_futter_project/presentation/widgets/app_badge.dart';

void main() {
  group('AppBadge', () {
    testWidgets('displays the correct text', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: AppBadge(text: '5')),
        ),
      );

      expect(find.text('5'), findsOneWidget);
    });

    testWidgets('has circular shape and black background', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: AppBadge(text: 'A')),
        ),
      );

      final container = tester.widget<Container>(find.byType(Container));
      final decoration = container.decoration as BoxDecoration;

      expect(decoration.shape, BoxShape.circle);
      expect(decoration.color, Colors.black);
    });

    testWidgets('uses correct text style', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: AppBadge(text: 'X')),
        ),
      );

      final textWidget = tester.widget<Text>(find.text('X'));
      final expectedStyle = AppTextStyles.zonaPro16.copyWith(color: Colors.white);

      expect(textWidget.style?.fontSize, expectedStyle.fontSize);
      expect(textWidget.style?.fontWeight, expectedStyle.fontWeight);
      expect(textWidget.style?.color, expectedStyle.color);
    });

    testWidgets('is centered and fits text', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: AppBadge(text: 'LongText')),
        ),
      );

      final fittedBox = find.byType(FittedBox);
      expect(fittedBox, findsOneWidget);

      final container = tester.widget<Container>(find.byType(Container));
      expect(container.alignment, Alignment.center);
    });
  });
}
