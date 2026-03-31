import 'package:flutter/material.dart';
import 'package:test_futter_project/common/app_colors.dart';
import 'package:test_futter_project/common/app_dimensions.dart';
import 'package:test_futter_project/common/extensions/context_extension.dart';
import 'package:test_futter_project/domain/models/region_ui_model.dart';
import 'package:test_futter_project/l10n/l10n_keys.dart';
import 'package:test_futter_project/presentation/widgets/dialogs/confirmation_dialog.dart';
import 'package:test_futter_project/presentation/widgets/dialogs/country_picker_bottom_sheet.dart';
import 'package:test_futter_project/presentation/widgets/dialogs/edit_password_dialog.dart';
import 'package:test_futter_project/presentation/widgets/dialogs/edit_personal_info_dialog.dart';
import 'package:test_futter_project/presentation/widgets/dialogs/gifs_picker_bottom_sheet.dart';
import 'package:test_futter_project/presentation/widgets/dialogs/inbox_item_menu_bottom_sheet.dart';

import '../common/app_semantics_labels.dart';
import '../presentation/widgets/app_semantics.dart';

class DialogHelper {
  static Future<void> showConfirmationDialog(
    BuildContext context, {
    required String title,
    required String description,
    required VoidCallback? onConfirm,
    required String confirmButtonTitle,
    required String cancelButtonTitle,
    bool isDeletion = true,
    VoidCallback? onCancel,
  }) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return ConfirmationDialog(
          title: title,
          description: description,
          confirmButtonTitle: confirmButtonTitle,
          cancelButtonTitle: cancelButtonTitle,
          onCancel: onCancel,
          onConfirm: onConfirm,
          isDeletion: isDeletion,
        );
      },
    );
  }

  static Future<void> showEditDialog(
    BuildContext context, {
    required String title,
    required String initialValue,
    required String confirmButtonTitle,
    required String cancelButtonTitle,
    required void Function(String)? onConfirm,
    VoidCallback? onCancel,
    bool Function(String)? validationCallback,
    TextInputType textInputType = TextInputType.text,
  }) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return EditPersonalInfoDialog(
          initialValue: initialValue,
          title: title,
          confirmButtonTitle: confirmButtonTitle,
          cancelButtonTitle: cancelButtonTitle,
          onConfirm: onConfirm,
          onCancel: onCancel,
          textInputType: textInputType,
          validationCallback: validationCallback,
        );
      },
    );
  }

  static Future<void> showEditPasswordDialog(
    BuildContext context, {
    required String title,
    required String confirmButtonTitle,
    required String cancelButtonTitle,
    required void Function(String)? onConfirm,
    VoidCallback? onCancel,
    bool Function(String)? validationCallback,
    bool isPasswordField = false,
  }) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return EditPasswordDialog(
          title: title,
          cancelButtonTitle: cancelButtonTitle,
          confirmButtonTitle: confirmButtonTitle,
          onCancel: onCancel,
          onConfirm: onConfirm,
          validationCallback: validationCallback,
          isPasswordField: isPasswordField,
        );
      },
    );
  }

  static Future<RegionUiModel?> showCountryPicker(
    BuildContext context,
    List<RegionUiModel> items,
    int currentIndex,
  ) async {
    return await showModalBottomSheet<RegionUiModel>(
      context: context,
      backgroundColor: Colors.white,
      clipBehavior: Clip.antiAlias,
      builder: (BuildContext context) {
        return CountryPickerBottomSheet(items: items, currentSelectedIndex: currentIndex);
      },
    );
  }

  static Future<void> showInboxItemModalBottomSheet(
    BuildContext context,
    String conversationId,
  ) async {
    await showModalBottomSheet(
      backgroundColor: AppColors.scaffoldColor,
      context: context,
      builder: (context) {
        return InboxItemMenuBottomSheet(conversationId: conversationId);
      },
    );
  }

  static Future<void> showGifsPickerModalBottomSheet(
    BuildContext context,
    GlobalKey<AnimatedListState> listKey,
  ) async {
    await showModalBottomSheet(
      backgroundColor: AppColors.scaffoldColor,
      context: context,
      builder: (context) => GifsPickerBottomSheet(listKey: listKey),
    );
  }

  static Future<void> showColorsPickerDialog(BuildContext context) async {
    final orientation = MediaQuery.orientationOf(context);

    final List<Color> colors = [
      Colors.red,
      Colors.pink,
      Colors.purple,
      Colors.deepPurple,
      Colors.indigo,
      Colors.blue,
      Colors.lightBlue,
      Colors.cyan,
      Colors.teal,
      Colors.green,
      Colors.lightGreen,
      Colors.lime,
      Colors.yellow,
      Colors.amber,
      Colors.orange,
      Colors.deepOrange,
      Colors.brown,
      Colors.grey,
      Colors.blueGrey,
      Colors.black,
    ];

    final color = await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: SizedBox(
            width: 300,
            height: orientation == Orientation.portrait ? 360 : 240,
            child: GridView.count(
              crossAxisCount: orientation == Orientation.portrait ? 4 : 5,
              crossAxisSpacing: AppDimensions.minorL,
              mainAxisSpacing: AppDimensions.minorL,
              children: [
                for (Color color in colors)
                  InkWell(
                    onTap: () {},
                    child: Container(
                      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
                    ),
                  ),
              ],
            ),
          ),
          actions: [
            AppSemantics(
              label: AppSemanticsLabels.dialogCancelButton,
              button: true,
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  context.trRead(L10nKeys.cancelLabel),
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
            ),
            AppSemantics(
              label: AppSemanticsLabels.dialogConfirmButton,
              button: true,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.resolveWith<Color?>((states) {
                    if (states.contains(WidgetState.disabled)) {
                      return Colors.grey;
                    }
                    return AppColors.headerColor;
                  }),
                  foregroundColor: const WidgetStatePropertyAll(Colors.white),
                ),
                child: Text(
                  context.trRead(L10nKeys.confirmLabel),
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
