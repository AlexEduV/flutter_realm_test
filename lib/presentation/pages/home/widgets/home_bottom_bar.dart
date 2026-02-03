import 'package:flutter/material.dart';

import '../../../../common/app_dimensions.dart';
import '../../../../utils/l10n.dart';

class HomeBottomBar extends StatelessWidget {
  final void Function() onAddPressed;

  const HomeBottomBar({required this.onAddPressed, super.key});

  @override
  Widget build(BuildContext context) {
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
              IconButton(
                icon: const Icon(Icons.home_outlined, size: AppDimensions.bottomAppBarIconSize),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.favorite_border, size: AppDimensions.bottomAppBarIconSize),
                onPressed: () {},
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
              IconButton(
                icon: const Icon(Icons.mail_outlined, size: AppDimensions.bottomAppBarIconSize),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.settings_outlined, size: AppDimensions.bottomAppBarIconSize),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
