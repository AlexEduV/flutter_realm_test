import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:test_flutter_project/common/constants/app_colors.dart';
import 'package:test_flutter_project/common/constants/app_dimensions.dart';
import 'package:test_flutter_project/common/enums/item_setup_tab.dart';
import 'package:test_flutter_project/presentation/pages/home/new_item_page/widgets/page_selection_bar.dart';

void main() {
  testWidgets('PageSelectionBar renders and triggers callbacks', (WidgetTester tester) async {
    // Arrange
    var backPressed = false;
    var forwardPressed = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: PageSelectionBar(
            onBackPressed: () => backPressed = true,
            onForwardPressed: () => forwardPressed = true,
            currentIndex: 1,
            iconColor: Colors.red,
            iconSize: 30,
          ),
        ),
      ),
    );

    // Assert: IconButtons are present
    final leftButton = find.widgetWithIcon(IconButton, Icons.chevron_left_outlined);
    final rightButton = find.widgetWithIcon(IconButton, Icons.chevron_right_outlined);
    expect(leftButton, findsOneWidget);
    expect(rightButton, findsOneWidget);

    // Assert: AnimatedSmoothIndicator is present and has correct index/count
    final indicator = find.byType(AnimatedSmoothIndicator);
    expect(indicator, findsOneWidget);
    final indicatorWidget = tester.widget<AnimatedSmoothIndicator>(indicator);
    expect(indicatorWidget.activeIndex, 1);
    expect(indicatorWidget.count, ItemSetupTab.values.length);

    // Assert: Icon color and size
    final leftIcon = tester.widget<Icon>(
      find.descendant(of: leftButton, matching: find.byType(Icon)),
    );
    expect(leftIcon.color, Colors.red);
    expect(leftIcon.size, 30);

    // Act: Tap left and right buttons
    await tester.tap(leftButton);
    await tester.tap(rightButton);

    // Assert: Callbacks triggered
    expect(backPressed, isTrue);
    expect(forwardPressed, isTrue);
  });

  testWidgets('PageSelectionBar uses default icon color and size', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: PageSelectionBar(onBackPressed: () {}, onForwardPressed: () {}, currentIndex: 0),
        ),
      ),
    );

    final leftIcon = tester.widget<Icon>(
      find.descendant(
        of: find.widgetWithIcon(IconButton, Icons.chevron_left_outlined),
        matching: find.byType(Icon),
      ),
    );
    expect(leftIcon.color, AppColors.headerColor);
    expect(leftIcon.size, AppDimensions.majorM);
  });
}
