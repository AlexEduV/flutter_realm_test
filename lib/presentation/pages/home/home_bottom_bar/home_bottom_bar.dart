import 'package:flutter/material.dart';
import 'package:test_futter_project/common/app_colors.dart';
import 'package:test_futter_project/common/app_constants.dart';
import 'package:test_futter_project/common/app_semantics_labels.dart';
import 'package:test_futter_project/presentation/pages/home/home_bottom_bar/widgets/animated_add_button.dart';
import 'package:test_futter_project/presentation/pages/home/home_bottom_bar/widgets/home_bottom_bar_item.dart';
import 'package:test_futter_project/presentation/widgets/app_semantics.dart';

import '../../../../common/app_dimensions.dart';

class HomeBottomBar extends StatelessWidget {
  final void Function() onAddPressed;

  const HomeBottomBar({required this.onAddPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: AppDimensions.normalL),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(AppDimensions.normalL),
          topRight: Radius.circular(AppDimensions.normalL),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withAlpha(60),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.normalXS),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const HomeBottomBarItem(
              semanticsLabel: AppSemanticsLabels.homeBottomBarItemHome,
              index: AppConstants.homeTabExplore,
              icon: Icons.home_outlined,
              label: 'Explore',
            ),
            const HomeBottomBarItem(
              semanticsLabel: AppSemanticsLabels.homeBottomBarItemFavorites,
              index: AppConstants.homeTabFavorites,
              icon: Icons.favorite_border,
              label: 'Favorites',
            ),

            AppSemantics(
              button: true,
              label: AppSemanticsLabels.homeBottomBarItemAdd,
              child: AnimatedAddButton(
                onPressed: onAddPressed,
                backgroundColor: AppColors.headerColor,
                size: AppDimensions.bottomAppBarIconEnlargedSize,
              ),
            ),

            const HomeBottomBarItem(
              index: AppConstants.homeTabInbox,
              icon: Icons.mail_outlined,
              semanticsLabel: AppSemanticsLabels.homeBottomBarItemInbox,
              label: 'Inbox',
            ),
            const HomeBottomBarItem(
              index: AppConstants.homeTabAccount,
              icon: Icons.person_2_outlined,
              semanticsLabel: AppSemanticsLabels.homeBottomBarItemAccount,
              label: 'Account',
            ),
          ],
        ),
      ),
    );
  }
}
