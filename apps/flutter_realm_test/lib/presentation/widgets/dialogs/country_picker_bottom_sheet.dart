import 'package:flutter/material.dart';
import 'package:test_flutter_project/common/constants/app_constants.dart';
import 'package:test_flutter_project/domain/models/region_ui_model.dart';
import 'package:test_flutter_project/presentation/widgets/skip_widget.dart';

import '../../../common/constants/app_asset_routes.dart';
import '../../../common/constants/app_colors.dart';
import '../../../common/constants/app_dimensions.dart';
import '../../../common/constants/app_text_styles.dart';

class CountryPickerBottomSheet extends StatelessWidget {
  final List<RegionUiModel> items;
  final int currentSelectedIndex;

  const CountryPickerBottomSheet({
    required this.items,
    required this.currentSelectedIndex,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
            child: SkipWidget(
              skip: AppConstants.kIsTest,
              child: Image.asset(
                '${AppAssetRoutes.flagRoute}${items[index].code}.png',
                height: AppDimensions.regionFlagIconSize,
                width: AppDimensions.regionFlagIconSize,
              ),
            ),
          ),
          title: Text(
            items[index].countryName,
            style: AppTextStyles.zonaPro16.copyWith(fontWeight: FontWeight.w600),
          ),
          selected: index == currentSelectedIndex,
          selectedTileColor: AppColors.lightGrey,
          onTap: () => Navigator.pop(context, items[index]),
        );
      },
    );
  }
}
