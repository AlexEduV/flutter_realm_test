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
    final double segmentWidth = 1 / options.length;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppDimensions.normalL),
      ),
      padding: EdgeInsets.all(AppDimensions.minorL),
      child: Stack(
        children: [
          AnimatedAlign(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            // Calculate alignment: -1.0 is far left, 1.0 is far right
            alignment: Alignment(-1.0 + (selectedIndex * (2.0 / (options.length - 1))), 0.0),
            child: FractionallySizedBox(
              widthFactor: segmentWidth,
              child: Container(
                height: 40, // Match your button height
                decoration: BoxDecoration(
                  color: AppColors.headerColor, // Your dark blue
                  borderRadius: BorderRadius.circular(AppDimensions.normalS),
                ),
              ),
            ),
          ),

          Row(
            children: List.generate(options.length, (index) {
              final isSelected = index == selectedIndex;
              return Expanded(
                child: GestureDetector(
                  onTap: () => onChanged(index),
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    height: 40,
                    alignment: Alignment.center,
                    child: AnimatedDefaultTextStyle(
                      duration: const Duration(milliseconds: 300),
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                      child: Text(options[index]),
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
