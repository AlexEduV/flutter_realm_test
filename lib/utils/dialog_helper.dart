import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_futter_project/common/app_asset_routes.dart';
import 'package:test_futter_project/common/app_colors.dart';
import 'package:test_futter_project/common/app_dimensions.dart';
import 'package:test_futter_project/common/app_text_styles.dart';
import 'package:test_futter_project/domain/models/region_ui_model.dart';
import 'package:test_futter_project/presentation/bloc/account/edit_dialog_cubit.dart';
import 'package:test_futter_project/presentation/bloc/account/edit_dialog_state.dart';

class DialogHelper {
  static void showConfirmationDialog(
    BuildContext context, {
    required String title,
    required String description,
    required VoidCallback? onConfirm,
    required String confirmButtonTitle,
    required String cancelButtonTitle,
    bool isDeletion = true,
    VoidCallback? onCancel,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title, style: AppTextStyles.zonaPro16.copyWith(fontWeight: FontWeight.w700)),
          content: Text(description),
          backgroundColor: Colors.white,
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                onCancel?.call();
              },
              child: Text(cancelButtonTitle, style: const TextStyle(fontWeight: FontWeight.w600)),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                onConfirm?.call();
              },
              style: isDeletion
                  ? const ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.red))
                  : null,
              child: Text(
                confirmButtonTitle,
                style: TextStyle(
                  color: isDeletion ? Colors.white : null,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  static void showEditDialog(
    BuildContext context, {
    required String title,
    required String description,
    required String confirmButtonTitle,
    required String cancelButtonTitle,
    required VoidCallback? onConfirm,
    VoidCallback? onCancel,
    bool Function(String)? validationCallback,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final textEditingController = TextEditingController(text: description);
        final focusNode = FocusNode();

        _validateEditField(context, description, validationCallback);

        return BlocBuilder<EditDialogCubit, EditDialogState>(
          builder: (context, state) {
            return AlertDialog(
              title: Text(
                title,
                style: AppTextStyles.zonaPro16.copyWith(fontWeight: FontWeight.w700),
              ),
              content: TextFormField(
                controller: textEditingController,
                focusNode: focusNode,
                onChanged: (newValue) => _validateEditField(context, newValue, validationCallback),
              ),
              backgroundColor: Colors.white,
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    onCancel?.call();
                  },
                  child: Text(
                    cancelButtonTitle,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
                ElevatedButton(
                  onPressed: state.isConfirmButtonEnabled
                      ? () {
                          Navigator.of(context).pop();
                          onConfirm?.call();
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
              ],
            );
          },
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
        return ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: AppDimensions.normalM),
          itemCount: items.length,
          itemBuilder: (context, index) {
            return ListTile(
              contentPadding: const EdgeInsetsGeometry.symmetric(
                horizontal: AppDimensions.normalM,
                vertical: AppDimensions.minorS,
              ),
              leading: Container(
                height: AppDimensions.regionFlagIconSize,
                width: AppDimensions.regionFlagIconSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(width: 3.0, color: AppColors.accentColor),
                ),
                child: Image.asset(
                  '${AppAssetRoutes.flagRoute}${items[index].code}.png',
                  height: AppDimensions.regionFlagIconSize,
                  width: AppDimensions.regionFlagIconSize,
                ),
              ),
              title: Text(
                items[index].countryName,
                style: AppTextStyles.zonaPro16.copyWith(fontWeight: FontWeight.w600),
              ),
              selected: index == currentIndex,
              selectedTileColor: AppColors.lightGrey,
              onTap: () => Navigator.pop(context, items[index]),
            );
          },
        );
      },
    );
  }

  static void _validateEditField(
    BuildContext context,
    String newValue,
    Function(String)? validationCallback,
  ) {
    final isValid = validationCallback?.call(newValue);
    context.read<EditDialogCubit>().setConfirmButtonEnabled(isValid ?? false);
  }
}
