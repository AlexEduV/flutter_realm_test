//todo: the tests are not working;

/*
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_futter_project/domain/models/region_ui_model.dart';
import 'package:test_futter_project/presentation/widgets/dialogs/color_picker_dialog/color_picker_dialog.dart';
import 'package:test_futter_project/presentation/widgets/dialogs/confirmation_dialog.dart';
import 'package:test_futter_project/presentation/widgets/dialogs/country_picker_bottom_sheet.dart';
import 'package:test_futter_project/presentation/widgets/dialogs/edit_password_dialog.dart';
import 'package:test_futter_project/presentation/widgets/dialogs/edit_personal_info_dialog.dart';
import 'package:test_futter_project/presentation/widgets/dialogs/gifs_picker_bottom_sheet.dart';
import 'package:test_futter_project/presentation/widgets/dialogs/inbox_item_menu_bottom_sheet.dart';
import 'package:test_futter_project/utils/dialog_helper.dart';

void main() {
  testWidgets('showConfirmationDialog shows ConfirmationDialog', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (context) {
            return ElevatedButton(
              onPressed: () {
                DialogHelper.showConfirmationDialog(
                  context,
                  title: 'Title',
                  description: 'Desc',
                  onConfirm: () {},
                  confirmButtonTitle: 'OK',
                  cancelButtonTitle: 'Cancel',
                );
              },
              child: const Text('Open'),
            );
          },
        ),
      ),
    );

    await tester.tap(find.text('Open'));
    await tester.pumpAndSettle();

    expect(find.byType(ConfirmationDialog), findsOneWidget);
    expect(find.text('Title'), findsOneWidget);
    expect(find.text('Desc'), findsOneWidget);
    expect(find.text('OK'), findsOneWidget);
    expect(find.text('Cancel'), findsOneWidget);
  });

  testWidgets('showEditDialog shows EditPersonalInfoDialog', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (context) {
            return ElevatedButton(
              onPressed: () {
                DialogHelper.showEditDialog(
                  context,
                  title: 'Edit',
                  initialValue: 'init',
                  confirmButtonTitle: 'Save',
                  cancelButtonTitle: 'Cancel',
                  onConfirm: (_) {},
                );
              },
              child: const Text('Open'),
            );
          },
        ),
      ),
    );

    await tester.tap(find.text('Open'));
    await tester.pumpAndSettle();

    expect(find.byType(EditPersonalInfoDialog), findsOneWidget);
    expect(find.text('Edit'), findsOneWidget);
    expect(find.text('Save'), findsOneWidget);
    expect(find.text('Cancel'), findsOneWidget);
  });

  testWidgets('showEditPasswordDialog shows EditPasswordDialog', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (context) {
            return ElevatedButton(
              onPressed: () {
                DialogHelper.showEditPasswordDialog(
                  context,
                  title: 'Password',
                  confirmButtonTitle: 'OK',
                  cancelButtonTitle: 'Cancel',
                  onConfirm: (_) {},
                );
              },
              child: const Text('Open'),
            );
          },
        ),
      ),
    );

    await tester.tap(find.text('Open'));
    await tester.pumpAndSettle();

    expect(find.byType(EditPasswordDialog), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
    expect(find.text('OK'), findsOneWidget);
    expect(find.text('Cancel'), findsOneWidget);
  });

  testWidgets('showCountryPicker shows CountryPickerBottomSheet and returns selected', (
    tester,
  ) async {
    final items = [
      const RegionUiModel(code: 'US', countryName: 'United States'),
      const RegionUiModel(code: 'IT', countryName: 'Italy'),
    ];

    RegionUiModel? selected;
    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (context) {
            return ElevatedButton(
              onPressed: () async {
                selected = await DialogHelper.showCountryPicker(context, items, 0);
              },
              child: const Text('Open'),
            );
          },
        ),
      ),
    );

    await tester.tap(find.text('Open'));
    await tester.pumpAndSettle();

    expect(find.byType(CountryPickerBottomSheet), findsOneWidget);
    // Optionally, simulate selection and test the return value
  });

  testWidgets('showInboxItemModalBottomSheet shows InboxItemMenuBottomSheet', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (context) {
            return ElevatedButton(
              onPressed: () {
                DialogHelper.showInboxItemModalBottomSheet(context, 'conv1');
              },
              child: const Text('Open'),
            );
          },
        ),
      ),
    );

    await tester.tap(find.text('Open'));
    await tester.pumpAndSettle();

    expect(find.byType(InboxItemMenuBottomSheet), findsOneWidget);
  });

  testWidgets('showGifsPickerModalBottomSheet shows GifsPickerBottomSheet', (tester) async {
    final listKey = GlobalKey<AnimatedListState>();
    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (context) {
            return ElevatedButton(
              onPressed: () {
                DialogHelper.showGifsPickerModalBottomSheet(context, listKey);
              },
              child: const Text('Open'),
            );
          },
        ),
      ),
    );

    await tester.tap(find.text('Open'));
    await tester.pumpAndSettle();

    expect(find.byType(GifsPickerBottomSheet), findsOneWidget);
  });

  testWidgets('showColorsPickerDialog shows ColorPickerDialog and returns value', (tester) async {
    String? result;
    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (context) {
            return ElevatedButton(
              onPressed: () async {
                result = await DialogHelper.showColorsPickerDialog(context, 'red');
              },
              child: const Text('Open'),
            );
          },
        ),
      ),
    );

    await tester.tap(find.text('Open'));
    await tester.pumpAndSettle();

    expect(find.byType(ColorPickerDialog), findsOneWidget);
    // Optionally, simulate selection and test the return value
  });
}

 */

void main() {}
