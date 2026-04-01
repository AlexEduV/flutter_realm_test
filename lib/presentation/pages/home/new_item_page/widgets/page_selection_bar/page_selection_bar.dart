import 'package:flutter/material.dart';
import 'package:test_futter_project/common/enums/item_setup_tab.dart';
import 'package:test_futter_project/presentation/pages/home/new_item_page/widgets/page_selection_bar/widgets/page_dot_widget.dart';

import '../../../../../../common/app_colors.dart';
import '../../../../../../common/app_dimensions.dart';

class PageSelectionBar extends StatefulWidget {
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
  State<PageSelectionBar> createState() => _PageSelectionBarState();
}

class _PageSelectionBarState extends State<PageSelectionBar> {
  int? _prevIndex;

  @override
  Widget build(BuildContext context) {
    final spacingBetweenDots = AppDimensions.minorL;
    final dotSize = AppDimensions.normalS;
    final isMoving = _prevIndex != null && _prevIndex != widget.currentIndex;

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
              icon: Icon(
                Icons.chevron_left_outlined,
                color: widget.iconColor,
                size: widget.iconSize,
              ),
              onPressed: widget.onBackPressed,
            ),
          ),

          SizedBox(
            width:
                ItemSetupTab.values.length * dotSize +
                (spacingBetweenDots * (ItemSetupTab.values.length - 1)),
            child: Stack(
              alignment: AlignmentGeometry.center,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  spacing: spacingBetweenDots,
                  children: [
                    ...ItemSetupTab.values.map((element) {
                      return const PageDotWidget();
                    }),
                  ],
                ),

                //the first index is working, but on index change nothing happens
                AnimatedAlign(
                  alignment: Alignment(getXAlignment(), 0.0),
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.fastOutSlowIn,
                  onEnd: () {
                    setState(() {
                      _prevIndex = null; // Reset after animation
                    });
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.fastOutSlowIn,
                    height: dotSize * 1.2,
                    width: isMoving ? dotSize * 2.2 : dotSize * 1.2,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(16.0)),
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
              icon: Icon(
                Icons.chevron_right_outlined,
                color: widget.iconColor,
                size: widget.iconSize,
              ),
              onPressed: widget.onForwardPressed,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void didUpdateWidget(covariant PageSelectionBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.currentIndex != oldWidget.currentIndex) {
      _prevIndex = oldWidget.currentIndex;
    }
  }

  double getXAlignment() {
    final alignment = -1.0 + (widget.currentIndex * (2.0 / (ItemSetupTab.values.length - 1)));
    return alignment;
  }
}
