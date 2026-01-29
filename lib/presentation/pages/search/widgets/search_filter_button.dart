import 'package:flutter/material.dart';
import 'package:test_futter_project/common/app_colors.dart';

import '../../../../common/app_dimensions.dart';
import '../../../../common/app_text_styles.dart';
import '../../../widgets/app_badge.dart';

class SearchFilterButton extends StatelessWidget {
  final String title;
  final String? text;
  final String selectionCount;
  final double iconSize;
  final IconData icon;
  final void Function()? onPressed;
  final bool isPlaceHolder;

  const SearchFilterButton({
    required this.title,
    required this.icon,
    required this.selectionCount,
    this.text,
    this.onPressed,
    this.iconSize = 40.0,
    this.isPlaceHolder = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.normalL,
        vertical: AppDimensions.contentPadding,
      ),
      child: Material(
        borderRadius: BorderRadius.circular(AppDimensions.normalL),
        child: InkWell(
          borderRadius: BorderRadius.circular(AppDimensions.normalL),
          onTap: onPressed,
          child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(AppDimensions.normalL)),
            padding: EdgeInsets.all(AppDimensions.normalL),
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppDimensions.normalXS),
                    color: AppColors.scaffoldColor,
                  ),
                  height: iconSize,
                  width: iconSize,
                  child: Icon(icon, color: AppColors.headerColor),
                ),

                SizedBox(width: AppDimensions.normalXS),

                Text(title, style: AppTextStyles.zonaPro16.copyWith(fontWeight: FontWeight.w600)),

                if (text != null) ...[
                  Expanded(
                    child: Text(
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      text.toString(),
                      style: AppTextStyles.zonaPro16.copyWith(
                        fontWeight: FontWeight.w600,
                        color: isPlaceHolder ? Colors.grey : null,
                      ),
                    ),
                  ),

                  SizedBox(width: AppDimensions.minorS),
                ] else ...[
                  Spacer(),
                ],

                AppBadge(text: selectionCount),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
