import 'package:flutter/material.dart';
import 'package:test_futter_project/common/app_colors.dart';
import 'package:test_futter_project/common/app_dimensions.dart';

class SegmentedSwitch extends StatelessWidget {
  final int selectedIndex;
  final List<String> options;
  final ValueChanged<int> onChanged;

  const SegmentedSwitch({
    required this.selectedIndex,
    required this.options,
    required this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    //todo: add a flowy animation, so that selected container flows to the new selected index,
    // since the width is the same.
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppDimensions.normalL),
      ),
      padding: EdgeInsets.symmetric(
        vertical: AppDimensions.minorS,
        horizontal: AppDimensions.minorL,
      ),
      child: Row(
        spacing: AppDimensions.minorM,
        children: List.generate(options.length, (index) {
          final isSelected = index == selectedIndex;
          return Expanded(
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: isSelected ? AppColors.headerColor : Colors.transparent,
                foregroundColor: isSelected ? Colors.white : Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppDimensions.normalS),
                ),
              ),
              onPressed: () => onChanged(index),
              child: Text(options[index]),
            ),
          );
        }),
      ),
    );
  }
}
