import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:test_flutter_project/presentation/features/search/search_page_identifiers.dart';
import 'package:test_flutter_project/presentation/widgets/app_semantics.dart';

import '../../../widgets/app_badge.dart';

class SearchFilterButton extends StatelessWidget {
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

  final String title;
  final String? text;
  final int selectionCount;
  final double iconSize;
  final IconData icon;
  final void Function()? onPressed;
  final bool isPlaceHolder;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.normalL,
        vertical: AppDimensions.contentPadding,
      ),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppDimensions.normalL),
        child: AppSemantics(
          button: true,
          label: '${SearchPageIds.filterButton} $title',
          child: InkWell(
            borderRadius: BorderRadius.circular(AppDimensions.normalL),
            onTap: onPressed,
            child: Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(AppDimensions.normalL)),
              padding: const EdgeInsets.all(AppDimensions.normalL),
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

                  const SizedBox(width: AppDimensions.normalXS),

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

                    const SizedBox(width: AppDimensions.minorS),
                  ] else ...[
                    const Spacer(),
                  ],

                  if (selectionCount > 0) ...[AppBadge(count: selectionCount)],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
