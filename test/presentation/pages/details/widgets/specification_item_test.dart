import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_futter_project/presentation/pages/details/widgets/specification_item.dart';

void main() {
  testWidgets('SpecificationItem displays title and subtitle', (WidgetTester tester) async {
    const title = 'Engine';
    const subtitle = 'V8 Turbo';

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: SpecificationItem(title: title, subtitle: subtitle),
        ),
      ),
    );

    expect(find.text(title), findsOneWidget);
    expect(find.text(subtitle), findsOneWidget);
  });

  testWidgets('SpecificationItem uses correct text styles', (WidgetTester tester) async {
    const title = 'Color';
    const subtitle = 'Red';

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: SpecificationItem(title: title, subtitle: subtitle),
        ),
      ),
    );

    final titleText = tester.widget<Text>(find.text(title));
    final subtitleText = tester.widget<Text>(find.text(subtitle));

    // You can check fontWeight or color if AppTextStyles.zonaPro16Grey/zonaPro18 are public
    expect(titleText.style?.fontWeight, FontWeight.w500);
    expect(subtitleText.style?.fontWeight, FontWeight.w600);
  });
}
