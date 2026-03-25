import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_futter_project/common/app_colors.dart';
import 'package:test_futter_project/common/app_dimensions.dart';
import 'package:test_futter_project/common/app_semantics_labels.dart';
import 'package:test_futter_project/common/app_text_styles.dart';
import 'package:test_futter_project/domain/models/region_ui_model.dart';
import 'package:test_futter_project/presentation/bloc/account/edit_dialog_cubit.dart';
import 'package:test_futter_project/presentation/bloc/account/edit_dialog_state.dart';
import 'package:test_futter_project/presentation/widgets/app_semantics.dart';
import 'package:test_futter_project/presentation/widgets/dialogs/confirmation_dialog.dart';
import 'package:test_futter_project/presentation/widgets/dialogs/country_picker_bottom_sheet.dart';
import 'package:test_futter_project/presentation/widgets/dialogs/edit_password_dialog.dart';
import 'package:test_futter_project/presentation/widgets/dialogs/gifs_picker_bottom_sheet.dart';
import 'package:test_futter_project/presentation/widgets/dialogs/inbox_item_menu_bottom_sheet.dart';

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
        final textEditingController = TextEditingController();
        final focusNode = FocusNode();

        textEditingController.text = initialValue;
        _validateEditField(context, textEditingController.text, validationCallback);

        return BlocBuilder<EditDialogCubit, EditDialogState>(
          builder: (context, state) {
            return AlertDialog(
              title: Text(
                title,
                style: AppTextStyles.zonaPro16.copyWith(fontWeight: FontWeight.w700),
              ),
              content: AppSemantics(
                textField: true,
                label: AppSemanticsLabels.dialogEditField,
                child: TextFormField(
                  controller: textEditingController,
                  focusNode: focusNode,
                  onChanged: (newValue) =>
                      _validateEditField(context, newValue, validationCallback),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppDimensions.normalS),
                      borderSide: const BorderSide(color: AppColors.accentColor),
                    ),
                  ),
                  keyboardType: textInputType,
                ),
              ),
              backgroundColor: Colors.white,
              actions: [
                AppSemantics(
                  label: AppSemanticsLabels.dialogCancelButton,
                  button: true,
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      onCancel?.call();
                    },
                    child: Text(
                      cancelButtonTitle,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                AppSemantics(
                  label: AppSemanticsLabels.dialogConfirmButton,
                  button: true,
                  enabled: state.isConfirmButtonEnabled,
                  child: ElevatedButton(
                    onPressed: state.isConfirmButtonEnabled
                        ? () {
                            Navigator.of(context).pop();
                            onConfirm?.call(textEditingController.text);
                          }
                        : null,
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
                      confirmButtonTitle,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ],
            );
          },
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

  static Future<void> showGifsPickerModalBottomSheet(BuildContext context) async {
    await showModalBottomSheet(
      backgroundColor: AppColors.scaffoldColor,
      context: context,
      builder: (context) => const GifsPickerBottomSheet(),
    );
  }

  static void _validateEditField(
    BuildContext context,
    String newValue,
    bool Function(String)? validationCallback,
  ) {
    final isValid = validationCallback?.call(newValue);
    context.read<EditDialogCubit>().setConfirmButtonEnabled(isValid ?? false);
  }
}
