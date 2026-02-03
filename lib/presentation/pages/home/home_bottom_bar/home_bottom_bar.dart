import 'package:flutter/material.dart';
import 'package:test_futter_project/common/app_constants.dart';
import 'package:test_futter_project/presentation/pages/home/home_bottom_bar/widgets/home_bottom_bar_item.dart';

import '../../../../common/app_dimensions.dart';
import '../../../../utils/l10n.dart';

class HomeBottomBar extends StatelessWidget {
  final void Function() onAddPressed;

  const HomeBottomBar({required this.onAddPressed, super.key});

  @override
  Widget build(BuildContext context) {
    //todo: add shadow to the top

    return BottomAppBar(
      padding: EdgeInsets.zero,
      child: Material(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(AppDimensions.normalL),
            topRight: Radius.circular(AppDimensions.normalL),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppDimensions.normalXS),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const HomeBottomBarItem(
                index: AppConstants.homeTabExplore,
                icon: Icons.home_outlined,
              ),
              const HomeBottomBarItem(
                index: AppConstants.homeTabFavorites,
                icon: Icons.favorite_border,
              ),

              IconButton(
                style: ButtonStyle(
                  backgroundColor: const WidgetStatePropertyAll(Colors.black),
                  foregroundColor: const WidgetStatePropertyAll(Colors.white),
                  overlayColor: WidgetStatePropertyAll(Colors.white.withAlpha(60)),
                ),
                icon: const Icon(Icons.add, size: AppDimensions.bottomAppBarIconEnlargedSize),
                onPressed: onAddPressed,
                tooltip: AppLocalisations.addCarButtonTooltip,
              ),

              const HomeBottomBarItem(index: AppConstants.homeTabInbox, icon: Icons.mail_outlined),
              const HomeBottomBarItem(
                index: AppConstants.homeTabSettings,
                icon: Icons.settings_outlined,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
