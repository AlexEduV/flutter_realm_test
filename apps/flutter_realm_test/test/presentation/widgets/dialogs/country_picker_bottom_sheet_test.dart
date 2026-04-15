import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_flutter_project/domain/models/region_ui_model.dart';
import 'package:test_flutter_project/presentation/widgets/dialogs/country_picker_bottom_sheet.dart';

void main() {
  testWidgets('CountryPickerBottomSheet renders items and handles selection', (
    WidgetTester tester,
  ) async {
    // Arrange
    final items = [
      const RegionUiModel(code: 'us', countryName: 'United States'),
      const RegionUiModel(code: 'it', countryName: 'Italy'),
      const RegionUiModel(code: 'fr', countryName: 'France'),
    ];

    // Build the widget inside a MaterialApp with a Navigator for pop
    RegionUiModel? selected;
    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (context) => Scaffold(
            body: ElevatedButton(
              onPressed: () async {
                selected = await showModalBottomSheet<RegionUiModel>(
                  context: context,
                  builder: (_) => CountryPickerBottomSheet(items: items, currentSelectedIndex: 1),
                );
              },
              child: const Text('Open'),
            ),
          ),
        ),
      ),
    );

    // Open the bottom sheet
    await tester.tap(find.text('Open'));
    await tester.pumpAndSettle();

    // Assert: All ListTiles are present
    expect(find.byType(ListTile), findsNWidgets(items.length));

    // Assert: Correct country names are displayed
    for (final item in items) {
      expect(find.text(item.countryName), findsOneWidget);
    }

    // Assert: The correct tile is selected
    final selectedTile = tester.widget<ListTile>(find.byType(ListTile).at(1));
    expect(selectedTile.selected, isTrue);

    // Act: Tap the third tile (France)
    await tester.tap(find.text('France'));
    await tester.pumpAndSettle();

    // Assert: The selected value is returned
    expect(selected, isNotNull);
    expect(selected!.code, 'fr');
    expect(selected!.countryName, 'France');
  });
}
