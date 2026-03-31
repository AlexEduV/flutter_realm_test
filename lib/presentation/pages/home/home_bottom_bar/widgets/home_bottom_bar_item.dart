import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_futter_project/common/app_colors.dart';
import 'package:test_futter_project/presentation/bloc/home/home_bottom_bar/home_bottom_bar_cubit.dart';
import 'package:test_futter_project/presentation/bloc/home/home_bottom_bar/home_bottom_bar_state.dart';
import 'package:test_futter_project/presentation/widgets/app_semantics.dart';

import '../../../../../common/app_dimensions.dart';

class HomeBottomBarItem extends StatelessWidget {
  final int index;
  final IconData icon;
  final String semanticsLabel;
  final String label;

  const HomeBottomBarItem({
    required this.index,
    required this.icon,
    required this.semanticsLabel,
    required this.label,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBottomBarCubit, HomeBottomBarState>(
      builder: (context, state) {
        final isSelected = state.currentSelectedTabIndex == index;
        final color = isSelected
            ? AppColors.headerColor
            : AppColors.headerColor.withAlpha((0.38 * 255).toInt());

        return AppSemantics(
          label: semanticsLabel,
          button: true,
          isSelected: isSelected,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(32),
              onTap: () => context.read<HomeBottomBarCubit>().updateSelectedIndex(index),
              child: Padding(
                padding: const EdgeInsets.all(AppDimensions.minorL),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  spacing: AppDimensions.minorS,
                  children: [
                    SizedBox(
                      height: AppDimensions.bottomAppBarIconSize,
                      width: AppDimensions.bottomAppBarIconSize,
                      child: Icon(icon, color: color),
                    ),

                    Text(
                      label,
                      style: TextStyle(
                        fontSize: isSelected ? 12 : 11,
                        fontWeight: FontWeight.w600,
                        color: color,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
