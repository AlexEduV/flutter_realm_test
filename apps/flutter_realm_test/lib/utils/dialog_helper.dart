import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:test_flutter_project/domain/models/region_ui_model.dart';
import 'package:test_flutter_project/presentation/features/color_picker/color_picker_dialog.dart';
import 'package:test_flutter_project/presentation/widgets/dialogs/acknowledgement_dialog.dart';
import 'package:test_flutter_project/presentation/widgets/dialogs/confirmation_dialog.dart';
import 'package:test_flutter_project/presentation/widgets/dialogs/country_picker_bottom_sheet.dart';
import 'package:test_flutter_project/presentation/widgets/dialogs/edit_password_dialog.dart';
import 'package:test_flutter_project/presentation/widgets/dialogs/edit_personal_info_dialog.dart';
import 'package:test_flutter_project/presentation/widgets/dialogs/gifs_picker_bottom_sheet.dart';
import 'package:test_flutter_project/presentation/widgets/dialogs/inbox_item_menu_bottom_sheet.dart';

class DialogHelper {
  static bool _isLocationPermissionDialogShowing = false;

  static Future<void> showConfirmationDialog(
    BuildContext context, {
    required String title,
    required String description,
    required VoidCallback? onConfirm,
    required String confirmButtonTitle,
    required String cancelButtonTitle,
    bool isAlertStyling = true,
    VoidCallback? onCancel,
  }) async {
    await showDialog(
      context: context,
      builder: (_) {
        return ConfirmationDialog(
          title: title,
          description: description,
          confirmButtonTitle: confirmButtonTitle,
          cancelButtonTitle: cancelButtonTitle,
          onCancel: onCancel,
          onConfirm: onConfirm,
          isAlertStyling: isAlertStyling,
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
      builder: (_) {
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
  }) async {
    await showDialog(
      context: context,
      builder: (_) {
        return EditPasswordDialog(
          title: title,
          cancelButtonTitle: cancelButtonTitle,
          confirmButtonTitle: confirmButtonTitle,
          onCancel: onCancel,
          onConfirm: onConfirm,
          validationCallback: validationCallback,
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
      backgroundColor: AppColors.scaffoldColor,
      clipBehavior: Clip.antiAlias,
      builder: (_) => CountryPickerBottomSheet(items: items, currentSelectedIndex: currentIndex),
    );
  }

  static Future<void> showInboxItemModalBottomSheet(
    BuildContext context,
    String conversationId,
  ) async {
    await showModalBottomSheet(
      backgroundColor: AppColors.scaffoldColor,
      context: context,
      builder: (_) => InboxItemMenuBottomSheet(conversationId: conversationId),
    );
  }

  static Future<void> showGifsPickerModalBottomSheet(
    BuildContext context,
    GlobalKey<AnimatedListState> listKey,
  ) async {
    await showModalBottomSheet(
      backgroundColor: AppColors.scaffoldColor,
      context: context,
      builder: (_) => GifsPickerBottomSheet(listKey: listKey),
    );
  }

  static Future<String?> showColorsPickerDialog(BuildContext context, String initialColor) async {
    final result = await showDialog<String>(
      context: context,
      builder: (_) => ColorPickerDialog(initialColor: initialColor),
    );

    return result;
  }

  static void dismissLocationPermissionDialog(BuildContext context) {
    if (_isLocationPermissionDialogShowing) {
      Navigator.of(context, rootNavigator: true).pop();
    }
  }

  static Future<void> showLocationPermissionDialog(
    BuildContext context, {
    required String title,
    required String description,
    required String confirmButtonTitle,
    required VoidCallback onConfirm,
  }) async {
    if (_isLocationPermissionDialogShowing) return;

    _isLocationPermissionDialogShowing = true;
    try {
      await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) {
          return AcknowledgementDialog(
            title: title,
            description: description,
            confirmButtonTitle: confirmButtonTitle,
            onConfirm: () => onConfirm.call(),
            icon: const Icon(Icons.pin_drop, color: AppColors.headerColor),
          );
        },
      );
    } finally {
      _isLocationPermissionDialogShowing = false;
    }
  }
}
