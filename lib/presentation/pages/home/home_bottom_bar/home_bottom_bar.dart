import 'package:flutter/material.dart';
import 'package:test_futter_project/common/app_colors.dart';
import 'package:test_futter_project/common/app_constants.dart';
import 'package:test_futter_project/common/app_semantics_labels.dart';
import 'package:test_futter_project/presentation/pages/home/home_bottom_bar/widgets/home_bottom_bar_item.dart';
import 'package:test_futter_project/presentation/widgets/app_semantics.dart';

import '../../../../common/app_dimensions.dart';
import '../../../../utils/l10n.dart';

class HomeBottomBar extends StatelessWidget {
  final void Function() onAddPressed;

  const HomeBottomBar({required this.onAddPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.white,
      padding: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.normalXS),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const HomeBottomBarItem(
              label: AppSemanticsLabels.homeBottomBarItemHome,
              index: AppConstants.homeTabExplore,
              icon: Icons.home_outlined,
            ),
            const HomeBottomBarItem(
              label: AppSemanticsLabels.homeBottomBarItemFavorites,
              index: AppConstants.homeTabFavorites,
              icon: Icons.favorite_border,
            ),

            AppSemantics(
              button: true,
              label: AppSemanticsLabels.homeBottomBarItemAdd,
              child: IconButton(
                style: ButtonStyle(
                  backgroundColor: const WidgetStatePropertyAll(AppColors.headerColor),
                  foregroundColor: const WidgetStatePropertyAll(Colors.white),
                  overlayColor: WidgetStatePropertyAll(Colors.white.withAlpha(60)),
                ),
                icon: const Icon(Icons.add, size: AppDimensions.bottomAppBarIconEnlargedSize),
                onPressed: onAddPressed,
                tooltip: AppLocalisations.addCarButtonTooltip,
              ),
            ),

            const HomeBottomBarItem(
              index: AppConstants.homeTabInbox,
              icon: Icons.mail_outlined,
              label: AppSemanticsLabels.homeBottomBarItemInbox,
            ),
            const HomeBottomBarItem(
              index: AppConstants.homeTabSettings,
              icon: Icons.settings_outlined,
              label: AppSemanticsLabels.homeBottomBarItemSettings,
            ),
          ],
        ),
      ),
    );
  }
}

class CircularNotchedAndRoundedRectangle extends NotchedShape {
  final double radius;

  const CircularNotchedAndRoundedRectangle({this.radius = 16});

  @override
  Path getOuterPath(Rect host, Rect? guest) {
    final r = radius;
    final path = Path();

    // Top left corner
    path.moveTo(host.left, host.top + r);
    path.quadraticBezierTo(host.left, host.top, host.left + r, host.top);

    // Notch for FAB
    if (guest != null) {
      final notchRadius = guest.width / 2.0;
      final notchCenter = guest.center.dx;
      final notchStart = notchCenter - notchRadius;
      final notchEnd = notchCenter + notchRadius;

      // Line to notch start
      path.lineTo(notchStart, host.top);

      // Notch arc
      path.arcToPoint(
        Offset(notchEnd, host.top),
        radius: Radius.circular(notchRadius),
        clockwise: false,
      );
    }

    // Top right corner
    path.lineTo(host.right - r, host.top);
    path.quadraticBezierTo(host.right, host.top, host.right, host.top + r);

    // Right, bottom, left sides
    path.lineTo(host.right, host.bottom);
    path.lineTo(host.left, host.bottom);
    path.close();

    return path;
  }
}
