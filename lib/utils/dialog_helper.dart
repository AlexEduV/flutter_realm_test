import 'package:flutter/material.dart';
import 'package:test_futter_project/common/app_asset_routes.dart';
import 'package:test_futter_project/common/app_colors.dart';
import 'package:test_futter_project/common/app_dimensions.dart';
import 'package:test_futter_project/common/app_text_styles.dart';
import 'package:test_futter_project/domain/models/region_ui_model.dart';

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
}
