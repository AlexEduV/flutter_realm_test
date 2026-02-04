/* import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_futter_project/common/app_colors.dart';
import 'package:test_futter_project/common/app_dimensions.dart';
import 'package:test_futter_project/presentation/pages/home/home_bottom_bar/home_bottom_bar.dart';
import 'package:test_futter_project/presentation/pages/home/home_bottom_bar/widgets/home_bottom_bar_item.dart';
import 'package:test_futter_project/utils/l10n.dart';

void main() {
  setUp(() {
    AppLocalisations.localisations = {'actions.addCar.tooltip': 'Add a car'};
  });

  group('HomeBottomBar', () {
    testWidgets('displays all HomeBottomBarItems and add button', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(bottomNavigationBar: HomeBottomBar(onAddPressed: () {})),
        ),
      );

      expect(find.byType(HomeBottomBarItem), findsNWidgets(4));
      expect(find.byIcon(Icons.add), findsOneWidget);
    });

    testWidgets('calls onAddPressed when add button is tapped', (WidgetTester tester) async {
      bool pressed = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            bottomNavigationBar: HomeBottomBar(
              onAddPressed: () {
                pressed = true;
              },
            ),
          ),
        ),
      );

      await tester.tap(find.byIcon(Icons.add));
      expect(pressed, isTrue);
    });

    testWidgets('add button has correct style and tooltip', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(bottomNavigationBar: HomeBottomBar(onAddPressed: () {})),
        ),
      );

      final iconButton = tester.widget<IconButton>(find.byIcon(Icons.add));
      final style = iconButton.style;
      final backgroundColor = style?.backgroundColor?.resolve({});
      final foregroundColor = style?.foregroundColor?.resolve({});
      final overlayColor = style?.overlayColor?.resolve({});

      expect(backgroundColor, AppColors.headerColor);
      expect(foregroundColor, Colors.white);
      expect(overlayColor, Colors.white.withAlpha(60));
      expect(iconButton.tooltip, AppLocalisations.addCarButtonTooltip);
    });

    testWidgets('container has correct decoration', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(bottomNavigationBar: HomeBottomBar(onAddPressed: () {})),
        ),
      );

      final container = tester.widget<Container>(
        find.descendant(of: find.byType(BottomAppBar), matching: find.byType(Container)),
      );

      final decoration = container.decoration as BoxDecoration;
      expect(decoration.color, Colors.white);
      expect(
        decoration.borderRadius,
        const BorderRadius.only(
          topLeft: Radius.circular(AppDimensions.normalL),
          topRight: Radius.circular(AppDimensions.normalL),
        ),
      );
      expect(decoration.boxShadow, isNotNull);
      expect(decoration.boxShadow!.first.color, Colors.grey.withAlpha(60));
    });
  });
}

 */

void main() {}
