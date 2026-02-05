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
  final String label;

  const HomeBottomBarItem({
    required this.index,
    required this.icon,
    required this.label,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBottomBarCubit, HomeBottomBarState>(
      builder: (context, state) {
        final isSelected = state.currentSelectedTabIndex == index;

        return AppSemantics(
          label: label,
          button: true,
          isSelected: isSelected,
          child: IconButton(
            style: ButtonStyle(
              foregroundColor: WidgetStatePropertyAll(
                isSelected
                    ? AppColors.headerColor
                    : AppColors.headerColor.withAlpha((0.38 * 255).toInt()),
              ),
              padding: const WidgetStatePropertyAll(EdgeInsets.all(AppDimensions.normalS)),
            ),
            icon: Icon(icon, size: AppDimensions.bottomAppBarIconSize),
            onPressed: () => context.read<HomeBottomBarCubit>().updateSelectedIndex(index),
          ),
        );
      },
    );
  }
}
