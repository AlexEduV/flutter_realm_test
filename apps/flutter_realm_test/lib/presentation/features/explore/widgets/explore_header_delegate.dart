import 'dart:ui';

import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:test_flutter_project/presentation/features/explore/explore_page_cubit.dart';
import 'package:test_flutter_project/presentation/features/explore/explore_page_identifiers.dart';
import 'package:test_flutter_project/presentation/widgets/app_semantics.dart';

import '../../../../../common/constants/app_routes.dart';
import '../explore_page_state.dart';
import 'article_item.dart';
import 'last_seen_widget.dart';

class ExploreHeaderDelegate extends SliverPersistentHeaderDelegate {
  ExploreHeaderDelegate({
    required this.minHeight,
    required this.maxHeightWithLastSeen,
    required this.maxHeightWithoutLastSeen,
    required this.showLastSeen,
    required this.title,
  });

  final double minHeight;
  final double maxHeightWithLastSeen;
  final double maxHeightWithoutLastSeen;
  final bool showLastSeen;
  final String title;

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
              top: AppDimensions.normalS,
              height: minHeight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(title, style: AppTextStyles.zonaPro30White),
                  Builder(
                    builder: (btnContext) => AppSemantics(
                      button: true,
                      label: ExplorePageIds.homePageSearchButton,
                      child: IconButton(
                        highlightColor: Colors.white10,
                        onPressed: () {
                          final box = btnContext.findRenderObject() as RenderBox?;
                          final origin = box?.localToGlobal(box.size.center(Offset.zero));
                          context.go(AppRoutes.home + AppRoutes.search, extra: origin);
                        },
                        icon: const Icon(
                          Icons.search,
                          size: AppDimensions.appBarIconSize,
                          color: AppColors.white,
                        ),
                      ),
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
              child: BlocBuilder<ExplorePageCubit, ExplorePageState>(
                builder: (context, state) {
                  return AnimatedSwitcher(
                    duration: const Duration(milliseconds: 400),
                    switchInCurve: Curves.easeIn,
                    switchOutCurve: Curves.easeOut,
                    child: Skeletonizer(
                      enabled: state.isArticleListLoading,
                      child: ListView.separated(
                        key: const ValueKey('list'),
                        itemCount: state.isArticleListLoading ? 10 : state.articles.length,
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.only(right: AppDimensions.normalL),
                        itemBuilder: (context, index) {
                          if (state.isArticleListLoading) {
                            return Padding(
                              padding: const EdgeInsets.all(AppDimensions.minorS),
                              child: Container(
                                width: AppDimensions.exploreArticleItemBaseSize,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(AppDimensions.normalL),
                                  color: AppColors.placeholderColor,
                                ),
                              ),
                            );
                          }
                          return Padding(
                            padding: const EdgeInsets.all(AppDimensions.minorS),
                            child: ArticleItem(
                              height: articleHeight,
                              article: state.articles[index],
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(width: AppDimensions.normalS);
                        },
                      ),
                    ),
                  );
                },
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
        showLastSeen != oldDelegate.showLastSeen ||
        title != oldDelegate.title;
  }
}
