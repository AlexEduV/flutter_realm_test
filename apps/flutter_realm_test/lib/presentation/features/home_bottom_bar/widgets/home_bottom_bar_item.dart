import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_flutter_project/presentation/features/home_bottom_bar/home_bottom_bar_cubit.dart';
import 'package:test_flutter_project/presentation/widgets/app_semantics.dart';

import '../home_bottom_bar_state.dart';

class HomeBottomBarItem extends StatelessWidget {
  const HomeBottomBarItem({
    required this.index,
    required this.selectedIcon,
    required this.unselectedIcon,
    required this.semanticsLabel,
    required this.label,
    this.iconRotationAngle = 0.0,
    this.borderRadius = AppDimensions.majorM,
    super.key,
  });

  final int index;
  final IconData selectedIcon;
  final IconData unselectedIcon;
  final String semanticsLabel;
  final String label;
  final double iconRotationAngle;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBottomBarCubit, HomeBottomBarState>(
      builder: (context, state) {
        final isSelected = state.currentSelectedTabIndex == index;
        final foregroundColor = isSelected
            ? AppColors.headerColor
            : AppColors.headerColor.withAlpha((0.48 * 255).toInt());

        final icon = isSelected ? selectedIcon : unselectedIcon;

        return AppSemantics(
          label: semanticsLabel,
          button: true,
          isSelected: isSelected,
          child: Material(
            color: AppColors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(borderRadius),
              //todo: use a callback here
              onTap: () => context.read<HomeBottomBarCubit>().updateSelectedIndex(index),
              child: SizedBox(
                height: 60,
                width: 73,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    spacing: AppDimensions.minorXS,
                    children: [
                      //Note: Transform.rotate is cheaper than RotatedBox()
                      Transform.rotate(
                        angle: iconRotationAngle,
                        child: Icon(icon, color: foregroundColor),
                      ),

                      Text(
                        label,
                        textAlign: TextAlign.center,
                        style: AppTextStyles.zonaPro12Bold.copyWith(color: foregroundColor),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
