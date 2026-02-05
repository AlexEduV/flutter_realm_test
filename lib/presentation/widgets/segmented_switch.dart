import 'package:flutter/material.dart';
import 'package:test_futter_project/common/app_colors.dart';
import 'package:test_futter_project/common/app_dimensions.dart';
import 'package:test_futter_project/common/app_semantics_labels.dart';

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
    final double segmentWidth = 1 / options.length;
    const buttonHeight = 40.0;
    const animationDuration = 400;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppDimensions.normalL),
      ),
      padding: const EdgeInsets.all(AppDimensions.minorL),
      child: Stack(
        children: [
          // Slider
          AnimatedAlign(
            duration: const Duration(milliseconds: animationDuration),
            curve: Curves.easeOutBack,
            // Calculate alignment: -1.0 is far left, 1.0 is far right
            alignment: Alignment(-1.0 + (selectedIndex * (2.0 / (options.length - 1))), 0.0),
            child: FractionallySizedBox(
              widthFactor: segmentWidth,
              child: Container(
                height: buttonHeight,
                decoration: BoxDecoration(
                  color: AppColors.headerColor, // Your dark blue
                  borderRadius: BorderRadius.circular(AppDimensions.normalS),
                ),
              ),
            ),
          ),

          //Buttons
          Semantics(
            label: AppSemanticsLabels.segmentedSwitch,
            child: Row(
              children: List.generate(options.length, (index) {
                final isSelected = index == selectedIndex;
                return Expanded(
                  child: Semantics(
                    button: true,
                    label: '${AppSemanticsLabels.segmentedSwitchButton} ${options[index]}',
                    selected: isSelected,
                    child: GestureDetector(
                      onTap: () => onChanged(index),
                      behavior: HitTestBehavior.opaque,
                      child: Container(
                        height: buttonHeight,
                        alignment: Alignment.center,
                        child: AnimatedDefaultTextStyle(
                          duration: const Duration(milliseconds: animationDuration),
                          style: TextStyle(
                            color: isSelected ? Colors.white : AppColors.headerColor,
                            fontWeight: FontWeight.w600,
                          ),
                          child: Text(options[index]),
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
