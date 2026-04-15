import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_flutter_project/common/constants/app_colors.dart';
import 'package:test_flutter_project/presentation/widgets/segmented_switch.dart';

void main() {
  group('SegmentedSwitch', () {
    testWidgets('displays all options', (WidgetTester tester) async {
      final options = ['A', 'B', 'C'];
      await tester.pumpWidget(
        MaterialApp(
          home: SegmentedSwitch(selectedIndex: 0, options: options, onChanged: (_) {}),
        ),
      );

      for (final option in options) {
        expect(find.text(option), findsOneWidget);
      }
    });

    testWidgets('highlights the selected option', (WidgetTester tester) async {
      final options = ['One', 'Two', 'Three'];
      await tester.pumpWidget(
        MaterialApp(
          home: SegmentedSwitch(selectedIndex: 1, options: options, onChanged: (_) {}),
        ),
      );

      final selectedText = tester.widget<AnimatedDefaultTextStyle>(
        find.ancestor(of: find.text('Two'), matching: find.byType(AnimatedDefaultTextStyle)),
      );
      expect(selectedText.style.color, Colors.white);

      final unselectedText = tester.widget<AnimatedDefaultTextStyle>(
        find.ancestor(of: find.text('One'), matching: find.byType(AnimatedDefaultTextStyle)),
      );
      expect(unselectedText.style.color, AppColors.headerColor);
    });

    testWidgets('calls onChanged with correct index when tapped', (WidgetTester tester) async {
      final options = ['X', 'Y', 'Z'];
      int? tappedIndex;
      await tester.pumpWidget(
        MaterialApp(
          home: SegmentedSwitch(
            selectedIndex: 0,
            options: options,
            onChanged: (index) {
              tappedIndex = index;
            },
          ),
        ),
      );

      await tester.tap(find.text('Y'));
      expect(tappedIndex, 1);

      await tester.tap(find.text('Z'));
      expect(tappedIndex, 2);
    });
  });
}
