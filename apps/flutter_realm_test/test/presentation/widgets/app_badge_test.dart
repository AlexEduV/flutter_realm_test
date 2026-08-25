import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppBadge', () {
    testWidgets('displays the correct text', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: Scaffold(body: AppBadge(count: 5))));

      expect(find.text('5'), findsOneWidget);
    });
  });
}
