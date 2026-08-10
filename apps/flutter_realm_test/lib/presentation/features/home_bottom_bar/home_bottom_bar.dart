import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:test_flutter_project/common/constants/app_constants.dart';
import 'package:test_flutter_project/common/constants/app_semantics_labels.dart';
import 'package:test_flutter_project/common/extensions/context_extension.dart';
import 'package:test_flutter_project/l10n/l10n_keys.dart';
import 'package:test_flutter_project/presentation/features/explore/explore_page_identifiers.dart';
import 'package:test_flutter_project/presentation/features/favorites/favorites_page_identifiers.dart';
import 'package:test_flutter_project/presentation/features/home_bottom_bar/widgets/animated_add_button.dart';
import 'package:test_flutter_project/presentation/features/home_bottom_bar/widgets/home_bottom_bar_item.dart';
import 'package:test_flutter_project/presentation/widgets/app_semantics.dart';

import '../../../common/extensions/num_extension.dart';

class HomeBottomBar extends StatelessWidget {
  const HomeBottomBar({required this.onAddPressed, super.key});

  final void Function() onAddPressed;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
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
        padding: const EdgeInsets.all(
          AppDimensions.normalXS,
        ).copyWith(bottom: AppDimensions.majorS),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            HomeBottomBarItem(
              semanticsLabel: AppSemanticsLabels.homeBottomBarItemHome,
              index: AppConstants.homeTabExplore,
              unselectedIcon: Icons.web_stories_outlined,
              selectedIcon: Icons.web_stories,
              label: context.tr(ExplorePageLocaleKeys.explorePageTitle),
              rotationAngle: 90.0.toRadians,
            ),
            HomeBottomBarItem(
              semanticsLabel: AppSemanticsLabels.homeBottomBarItemFavorites,
              index: AppConstants.homeTabFavorites,
              unselectedIcon: Icons.favorite_border_outlined,
              selectedIcon: Icons.favorite_outlined,
              label: context.tr(FavoritesPageLocaleKeys.favoritesPageTitle),
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
              unselectedIcon: Icons.mail_outlined,
              selectedIcon: Icons.mail,
              semanticsLabel: AppSemanticsLabels.homeBottomBarItemInbox,
              label: context.tr(L10nKeys.inboxPageTitle),
            ),
            HomeBottomBarItem(
              index: AppConstants.homeTabAccount,
              unselectedIcon: Icons.person_2_outlined,
              selectedIcon: Icons.person_2,
              semanticsLabel: AppSemanticsLabels.homeBottomBarItemAccount,
              label: context.tr(L10nKeys.accountPageTitle),
            ),
          ],
        ),
      ),
    );
  }
}
