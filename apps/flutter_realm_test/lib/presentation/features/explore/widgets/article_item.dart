import 'package:cached_network_image/cached_network_image.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_flutter_project/core/router/app_router.dart';
import 'package:test_flutter_project/domain/entities/article_entity.dart';
import 'package:test_flutter_project/presentation/features/explore/explore_page_identifiers.dart';
import 'package:test_flutter_project/presentation/widgets/app_semantics.dart';

import '../explore_page_cubit.dart';

class ArticleItem extends StatelessWidget {
  const ArticleItem({
    required this.article,
    this.height = AppDimensions.exploreArticleItemBaseSize,
    this.borderRadius = AppDimensions.normalL,
    super.key,
  });

  final double height;
  final ArticleEntity article;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 1.0, end: article.isHovering ? 1.07 : 1.0),
      curve: Curves.easeOut,
      duration: const Duration(milliseconds: 120),
      builder: (context, scale, child) {
        return Transform.scale(alignment: Alignment.center, scale: scale, child: child);
      },
      child: AppSemantics(
        label: ExplorePageIds.exploreArticleItem,
        button: true,
        child: Material(
          color: AppColors.accentColor.withAlpha(60),
          borderRadius: BorderRadius.circular(borderRadius),
          child: InkWell(
            onTap: () => AppRouter.goToArticle(context: context, articleId: article.id),
            onTapDown: (_) => _setPressed(context, true),
            onTapUp: (_) => _setPressed(context, false),
            onTapCancel: () => _setPressed(context, false),
            borderRadius: BorderRadius.circular(borderRadius),
            child: SizedBox(
              height: height,
              width: AppDimensions.exploreArticleItemBaseSize,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(borderRadius),
                  color: AppColors.accentColor.withAlpha(60),
                ),
                child: Stack(
                  children: [
                    // Cached network image as background
                    ClipRRect(
                      borderRadius: BorderRadius.circular(borderRadius),
                      child: CachedNetworkImage(
                        imageUrl: article.imageUrl ?? '',
                        fit: BoxFit.cover,
                        width: AppDimensions.exploreArticleItemBaseSize,
                        height: height,
                        placeholder: (context, url) =>
                            ColoredBox(color: AppColors.placeholderColor),
                        errorWidget: (context, url, error) => const Icon(Icons.error),
                        color: AppColors.black.withAlpha(70),
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
                          style: AppTextStyles.zonaPro16White.copyWith(fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _setPressed(BuildContext context, bool isPressed) {
    context.read<ExplorePageCubit>().hoverArticle(article.id, isPressed);
  }
}
