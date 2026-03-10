import 'package:flutter/material.dart';
import 'package:test_futter_project/common/app_semantics_labels.dart';
import 'package:test_futter_project/common/extensions/context_extension.dart';
import 'package:test_futter_project/domain/entities/car_entity.dart';
import 'package:test_futter_project/presentation/widgets/app_semantics.dart';

import '../../../../common/app_colors.dart';
import '../../../../common/app_dimensions.dart';
import '../../../../common/app_text_styles.dart';
import '../../../../utils/l10n_keys.dart';

class OwnerWidget extends StatelessWidget {
  final CarEntity car;

  const OwnerWidget({required this.car, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: AppDimensions.normalL),
      decoration: const BoxDecoration(
        color: AppColors.scaffoldColor,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(AppDimensions.normalL),
          topLeft: Radius.circular(AppDimensions.normalL),
          bottomRight: Radius.circular(AppDimensions.normalXL),
          bottomLeft: Radius.circular(AppDimensions.normalXL),
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppDimensions.normalM),
            child: Row(
              spacing: AppDimensions.normalM,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundColor: AppColors.placeholderColor,
                  radius: AppDimensions.normalXL,
                ),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        car.owner?.name ?? '',
                        style: AppTextStyles.zonaPro18.copyWith(fontWeight: FontWeight.w600),
                      ),

                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              maxLines: 1,
                              context.tr(L10nKeys.ownerSectionPersonTypeOwner),
                              style: AppTextStyles.zonaPro16Grey.copyWith(
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),

                          const Icon(
                            Icons.location_pin,
                            size: AppDimensions.detailsPageItemIconSize,
                            color: Colors.grey,
                          ),

                          Flexible(
                            child: Text(
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              '${car.distanceTo ?? ''} ${context.tr(L10nKeys.distanceWidgetText)}',
                              style: AppTextStyles.zonaPro16Grey.copyWith(
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: AppDimensions.normalL),

          SizedBox(
            width: double.infinity, // Makes the button full width
            child: AppSemantics(
              button: true,
              label: AppSemanticsLabels.detailsPageContactButton,
              child: ElevatedButton(
                onPressed: () {
                  // Your action here
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    vertical: AppDimensions.normalM,
                  ), // Button height
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      AppDimensions.normalXL,
                    ), // Optional rounded corners
                  ),
                  backgroundColor: AppColors.headerColor,
                  foregroundColor: Colors.white,
                ),
                child: Text(
                  context.tr(L10nKeys.ownerSectionContactButtonTitle),
                  style: AppTextStyles.zonaPro16,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
