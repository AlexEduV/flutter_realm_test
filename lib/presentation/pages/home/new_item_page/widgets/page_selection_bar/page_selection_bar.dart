import 'package:flutter/material.dart';
import 'package:test_futter_project/common/enums/item_setup_tab.dart';
import 'package:test_futter_project/presentation/pages/home/new_item_page/widgets/page_selection_bar/widgets/page_dot_widget.dart';

import '../../../../../../common/app_colors.dart';
import '../../../../../../common/app_dimensions.dart';

class PageSelectionBar extends StatelessWidget {
  final Function() onForwardPressed;
  final Function() onBackPressed;
  final int currentIndex;
  final Color iconColor;
  final double iconSize;

  const PageSelectionBar({
    required this.onBackPressed,
    required this.onForwardPressed,
    required this.currentIndex,
    this.iconSize = AppDimensions.majorM,
    this.iconColor = AppColors.headerColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppDimensions.majorM),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(40),
            offset: const Offset(0, AppDimensions.minorL),
            blurRadius: 12,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Row(
        spacing: AppDimensions.minorL,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(AppDimensions.minorM),
            child: IconButton(
              icon: Icon(Icons.chevron_left_outlined, color: iconColor, size: iconSize),
              onPressed: onBackPressed,
            ),
          ),

          SizedBox(
            width:
                ItemSetupTab.values.length * AppDimensions.normalS +
                (AppDimensions.minorL * (ItemSetupTab.values.length - 1)),
            child: Stack(
              alignment: AlignmentGeometry.center,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  spacing: AppDimensions.minorL,
                  children: [
                    ...ItemSetupTab.values.map((element) {
                      return const PageDotWidget(isCurrentIndex: false);
                    }),
                  ],
                ),

                //the first index is working, but on index change nothing happens
                AnimatedAlign(
                  alignment: Alignment(getXAlignment(), 0.0),
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.fastOutSlowIn,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.fastOutSlowIn,
                    height: AppDimensions.normalS * 1.2,
                    width: AppDimensions.normalS * 1.2,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.headerColor,
                    ),
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(AppDimensions.minorM),
            child: IconButton(
              icon: Icon(Icons.chevron_right_outlined, color: iconColor, size: iconSize),
              onPressed: onForwardPressed,
            ),
          ),
        ],
      ),
    );
  }

  double getXAlignment() {
    final alignment = -1.0 + (currentIndex * (2.0 / (ItemSetupTab.values.length - 1)));
    return alignment;
  }
}
