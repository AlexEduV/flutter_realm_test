import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_flutter_project/presentation/widgets/dialogs/color_picker_dialog/color_item.dart';

void main() {
  testWidgets('ColorItem renders and triggers onTap', (WidgetTester tester) async {
    // Arrange
    bool tapped = false;
    const testColor = Colors.red;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ColorItem(
            color: testColor,
            isPicked: true,
            onTap: () {
              tapped = true;
            },
          ),
        ),
      ),
    );

    // Assert: Material and InkWell are present
    expect(find.byType(InkWell), findsOneWidget);

    // Assert: Icon is visible when isPicked is true
    final animatedOpacity = tester.widget<AnimatedOpacity>(find.byType(AnimatedOpacity));
    expect(animatedOpacity.opacity, 1.0);

    // Assert: Icon is present
    expect(find.byIcon(Icons.done), findsOneWidget);

    // Act: Tap the item
    await tester.tap(find.byType(InkWell));
    expect(tapped, isTrue);
  });

  testWidgets('ColorItem hides icon when isPicked is false', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ColorItem(color: Colors.blue, isPicked: false, onTap: () {}),
        ),
      ),
    );

    // Assert: AnimatedOpacity opacity is 0.0
    final animatedOpacity = tester.widget<AnimatedOpacity>(find.byType(AnimatedOpacity));
    expect(animatedOpacity.opacity, 0.0);

    // Assert: Icon is present in the widget tree (but hidden)
    expect(find.byIcon(Icons.done), findsOneWidget);
  });
}
