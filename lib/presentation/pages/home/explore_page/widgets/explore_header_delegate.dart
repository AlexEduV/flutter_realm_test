import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:test_futter_project/presentation/bloc/home/explore_page/explore_page_cubit.dart';
import 'package:test_futter_project/presentation/bloc/home/explore_page/explore_page_state.dart';

import '../../../../../common/app_colors.dart';
import '../../../../../common/app_dimensions.dart';
import '../../../../../common/app_routes.dart';
import '../../../../../common/app_text_styles.dart';
import '../../../../../utils/l10n/l10n.dart';
import 'explore_article_item.dart';
import 'last_seen_widget.dart';

class ExploreHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeightWithLastSeen;
  final double maxHeightWithoutLastSeen;
  final bool showLastSeen;

  ExploreHeaderDelegate({
    required this.minHeight,
    required this.maxHeightWithLastSeen,
    required this.maxHeightWithoutLastSeen,
    required this.showLastSeen,
  });

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => showLastSeen ? maxHeightWithLastSeen : maxHeightWithoutLastSeen;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    final progress = (shrinkOffset / (maxExtent - minExtent)).clamp(0.0, 1.0);
    final articleHeight = lerpDouble(AppDimensions.exploreArticleItemBaseSize, 90, progress)!;
    final lastSeenOpacity = showLastSeen ? (1.0 - progress) : 0.0;

    return ClipRRect(
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(AppDimensions.normalL),
        bottomRight: Radius.circular(AppDimensions.normalL),
      ),
      child: Material(
        color: AppColors.headerColor,
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
                  Text(
                    AppLocalisations.of(context).explorePageTitle,
                    style: AppTextStyles.zonaPro30White,
                  ),
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
                child: BlocBuilder<ExplorePageCubit, ExplorePageState>(
                  builder: (context, state) {
                    return AnimatedSwitcher(
                      duration: const Duration(milliseconds: 400),
                      switchInCurve: Curves.easeIn,
                      switchOutCurve: Curves.easeOut,
                      child: state.isArticleListLoading
                          ? const Center(
                              key: ValueKey('loading'),
                              child: SizedBox(
                                height: AppDimensions.smallProgressBarSize,
                                width: AppDimensions.smallProgressBarSize,
                                child: CircularProgressIndicator(color: Colors.white),
                              ),
                            )
                          : ListView.separated(
                              key: const ValueKey('list'),
                              itemCount: state.articles.length,
                              scrollDirection: Axis.horizontal,
                              padding: const EdgeInsets.only(right: AppDimensions.normalL),
                              itemBuilder: (context, index) {
                                return AnimatedPadding(
                                  curve: Curves.easeOut,
                                  duration: const Duration(milliseconds: 120),
                                  padding: EdgeInsets.symmetric(
                                    vertical: !state.articles[index].isHovering
                                        ? (AppDimensions.exploreArticleItemBaseSize * 1.07 -
                                                  AppDimensions.exploreArticleItemBaseSize) /
                                              2
                                        : 0,
                                  ),
                                  child: ExploreArticleItem(
                                    height: articleHeight,
                                    article: state.articles[index],
                                    index: index,
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) {
                                return const SizedBox(width: AppDimensions.normalS);
                              },
                            ),
                    );
                  },
                ),
              ),
            ),
            // Last Seen Widget (only if not empty)
            if (showLastSeen)
              Positioned(
                top: minHeight + articleHeight + AppDimensions.minorL,
                left: 0,
                right: 0,
                child: Opacity(opacity: lastSeenOpacity, child: const LastSeenWidget()),
              ),
          ],
        ),
      ),
    );
  }

  @override
  bool shouldRebuild(covariant ExploreHeaderDelegate oldDelegate) {
    return minHeight != oldDelegate.minHeight ||
        maxHeightWithLastSeen != oldDelegate.maxHeightWithLastSeen ||
        maxHeightWithoutLastSeen != oldDelegate.maxHeightWithoutLastSeen ||
        showLastSeen != oldDelegate.showLastSeen;
  }
}
