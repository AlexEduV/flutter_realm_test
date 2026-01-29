import 'package:flutter/material.dart';
import 'package:test_futter_project/common/app_colors.dart';

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
    return Container(
      decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(8)),
      child: Row(
        children: List.generate(options.length, (index) {
          final isSelected = index == selectedIndex;
          return Expanded(
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: isSelected ? AppColors.headerColor : Colors.transparent,
                foregroundColor: isSelected ? Colors.white : Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.horizontal(
                    left: index == 0 ? Radius.circular(8) : Radius.zero,
                    right: index == options.length - 1 ? Radius.circular(8) : Radius.zero,
                  ),
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
