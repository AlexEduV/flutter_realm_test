import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../common/app_colors.dart';
import '../../../../../common/app_dimensions.dart';
import '../../../../../common/app_routes.dart';
import '../../../../../common/app_text_styles.dart';
import '../../../../../utils/l10n.dart';
import 'explore_article_item.dart';
import 'last_seen_widget.dart';

class ExploreHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight; // Height of collapsed app bar
  final double maxHeight; // Height when fully expanded

  ExploreHeaderDelegate({required this.minHeight, required this.maxHeight});

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    // Calculate how much the header is collapsed (0.0 = expanded, 1.0 = collapsed)
    final progress = (shrinkOffset / (maxExtent - minExtent)).clamp(0.0, 1.0);

    // Interpolate heights for the article list and last seen widget
    final articleHeight = lerpDouble(120, 60, progress)!; // Example values
    final lastSeenOpacity = 1.0 - progress; // Fades out as you scroll

    return Material(
      color: AppColors.headerColor,
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(AppDimensions.normalL),
        bottomRight: Radius.circular(AppDimensions.normalL),
      ),
      child: Stack(
        children: [
          // App bar title and search icon
          Positioned(
            left: AppDimensions.normalL,
            right: AppDimensions.normalL,
            top: 12,
            height: minHeight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(AppLocalisations.explorePageTitle, style: AppTextStyles.zonaPro30White),
                IconButton(
                  onPressed: () => context.go(AppRoutes.home + AppRoutes.search),
                  icon: const Icon(
                    Icons.search,
                    size: AppDimensions.appBarIconSize,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          // Horizontal article list
          Positioned(
            left: AppDimensions.normalL,
            right: 0,
            top: minHeight,
            height: articleHeight,
            child: Opacity(
              opacity: 1.0,
              child: ListView.separated(
                itemCount: 3,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return ExploreArticleItem(
                    height: articleHeight,
                    articleName: 'Some Article here',
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(width: AppDimensions.normalS);
                },
              ),
            ),
          ),
          // Last Seen Widget (fades out as you scroll)
          Positioned(
            top: minHeight + articleHeight + AppDimensions.minorL,
            left: 0,
            right: 0,
            child: Opacity(opacity: lastSeenOpacity, child: const LastSeenWidget()),
          ),
        ],
      ),
    );
  }

  @override
  bool shouldRebuild(covariant ExploreHeaderDelegate oldDelegate) {
    return minHeight != oldDelegate.minHeight || maxHeight != oldDelegate.maxHeight;
  }
}
