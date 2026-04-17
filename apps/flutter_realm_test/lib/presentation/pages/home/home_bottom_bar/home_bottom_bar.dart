import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:test_flutter_project/common/constants/app_colors.dart';
import 'package:test_flutter_project/common/constants/app_constants.dart';
import 'package:test_flutter_project/common/constants/app_semantics_labels.dart';
import 'package:test_flutter_project/common/extensions/context_extension.dart';
import 'package:test_flutter_project/l10n/l10n_keys.dart';
import 'package:test_flutter_project/presentation/pages/home/home_bottom_bar/widgets/animated_add_button.dart';
import 'package:test_flutter_project/presentation/pages/home/home_bottom_bar/widgets/home_bottom_bar_item.dart';
import 'package:test_flutter_project/presentation/widgets/app_semantics.dart';

import '../../../../common/constants/app_dimensions.dart';
import '../../../../common/extensions/num_extension.dart';

class HomeBottomBar extends StatelessWidget {
  final void Function() onAddPressed;

  const HomeBottomBar({required this.onAddPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(AppDimensions.normalL),
        topRight: Radius.circular(AppDimensions.normalL),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: AppDimensions.normalS,
          sigmaY: AppDimensions.normalS,
        ), // Adjust blur as needed
        child: DecoratedBox(
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
            color: Colors.white.withAlpha(210),
          ),
          child: Padding(
            padding: const EdgeInsets.all(
              AppDimensions.normalXS,
            ).copyWith(bottom: AppDimensions.majorS),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                HomeBottomBarItem(
                  semanticsLabel: AppSemanticsLabels.homeBottomBarItemHome,
                  index: AppConstants.homeTabExplore,
                  icon: Icons.web_stories_outlined,
                  label: context.tr(L10nKeys.explorePageTitle),
                  rotationAngle: 90.0.toRadians,
                ),
                HomeBottomBarItem(
                  semanticsLabel: AppSemanticsLabels.homeBottomBarItemFavorites,
                  index: AppConstants.homeTabFavorites,
                  icon: Icons.favorite_border_outlined,
                  label: context.tr(L10nKeys.favoritesPageTitle),
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
                HomeBottomBarItem(
                  index: AppConstants.homeTabInbox,
                  icon: Icons.mail_outlined,
                  semanticsLabel: AppSemanticsLabels.homeBottomBarItemInbox,
                  label: context.tr(L10nKeys.inboxPageTitle),
                ),
                HomeBottomBarItem(
                  index: AppConstants.homeTabAccount,
                  icon: Icons.person_2_outlined,
                  semanticsLabel: AppSemanticsLabels.homeBottomBarItemAccount,
                  label: context.tr(L10nKeys.accountPageTitle),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
