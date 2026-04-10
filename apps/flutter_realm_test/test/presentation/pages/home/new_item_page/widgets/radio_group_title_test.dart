import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_futter_project/common/constants/app_colors.dart';
import 'package:test_futter_project/common/constants/app_text_styles.dart';
import 'package:test_futter_project/presentation/pages/home/new_item_page/widgets/radio_group_title.dart';

void main() {
  testWidgets('RadioGroupTitle displays the correct text and style', (WidgetTester tester) async {
    // Arrange
    const testText = 'Test Title';

    // Act
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(body: RadioGroupTitle(text: testText)),
      ),
    );

    // Assert
    // Check that a Row is present
    expect(find.byType(Row), findsOneWidget);

    // Check that the text is present
    expect(find.text(testText), findsOneWidget);

    // Check that the Text widget has the correct style
    final textWidget = tester.widget<Text>(find.text(testText));
    final style = textWidget.style!;
    expect(style.fontWeight, FontWeight.w600);
    expect(style.color, AppColors.placeholderColorDark);
    expect(style.fontSize, AppTextStyles.zonaPro14.fontSize);
    // Optionally, check fontFamily or other style properties if needed
  });
}
