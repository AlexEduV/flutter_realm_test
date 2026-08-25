import 'package:cached_network_image/cached_network_image.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_flutter_project/core/router/app_router.dart';
import 'package:test_flutter_project/domain/entities/article_entity.dart';
import 'package:test_flutter_project/presentation/features/explore/explore_page_identifiers.dart';
import 'package:test_flutter_project/presentation/widgets/app_semantics.dart';

import '../explore_page_cubit.dart';
import '../explore_page_state.dart';

class ArticleItem extends StatelessWidget {
  const ArticleItem({
    required this.index,
    required this.article,
    this.height = AppDimensions.exploreArticleItemBaseSize,
    super.key,
  });

  final double height;
  final ArticleEntity article;
  final int index;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExplorePageCubit, ExplorePageState>(
      builder: (context, state) {
        return TweenAnimationBuilder<double>(
          tween: Tween<double>(begin: 1.0, end: state.articles[index].isHovering ? 1.07 : 1.0),
          curve: Curves.easeOut,
          duration: const Duration(milliseconds: 120),
          builder: (context, scaleX, child) {
            return Transform(
              alignment: Alignment.center,
              transform: Matrix4.diagonal3Values(scaleX, scaleX, 1.0),
              child: child,
            );
          },
          child: AppSemantics(
            label: ExplorePageIds.exploreArticleItem,
            button: true,
            child: Material(
              color: AppColors.accentColor.withAlpha(60),
              borderRadius: BorderRadius.circular(AppDimensions.normalL),
              child: InkWell(
                onTap: () => AppRouter.goToArticle(context: context, articleId: article.id),
                onTapDown: (_) => _setPressed(context, true),
                onTapUp: (_) => _setPressed(context, false),
                onTapCancel: () => _setPressed(context, false),
                borderRadius: BorderRadius.circular(AppDimensions.normalL),
                child: Container(
                  height: height,
                  width: AppDimensions.exploreArticleItemBaseSize,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppDimensions.normalL),
                    color: AppColors.accentColor.withAlpha(60),
                  ),
                  child: Stack(
                    children: [
                      // Cached network image as background
                      ClipRRect(
                        borderRadius: BorderRadius.circular(AppDimensions.normalL),
                        child: CachedNetworkImage(
                          imageUrl: article.imageUrl ?? '',
                          fit: BoxFit.cover,
                          width: AppDimensions.exploreArticleItemBaseSize,
                          height: height,
                          placeholder: (context, url) =>
                              ColoredBox(color: AppColors.placeholderColor),
                          errorWidget: (context, url, error) => const Icon(Icons.error),
                          color: Colors.black.withAlpha(70),
                          colorBlendMode: BlendMode.darken,
                        ),
                      ),
                      // Article title
                      Padding(
                        padding: const EdgeInsets.all(AppDimensions.minorL),
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            article.title,
                            maxLines: 2,
                            style: AppTextStyles.zonaPro16White.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _setPressed(BuildContext context, bool isPressed) {
    final cubit = context.read<ExplorePageCubit>();
    final state = cubit.state;

    cubit.hoverArticle(state.articles[index].id, isPressed);
  }
}
