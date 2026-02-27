import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:test_futter_project/common/app_dimensions.dart';
import 'package:test_futter_project/common/app_routes.dart';
import 'package:test_futter_project/common/app_semantics_labels.dart';
import 'package:test_futter_project/common/app_text_styles.dart';
import 'package:test_futter_project/domain/entities/article_entity.dart';
import 'package:test_futter_project/presentation/widgets/app_semantics.dart';

import '../../../../../common/app_colors.dart';

class ExploreArticleItem extends StatefulWidget {
  final double height;
  final ArticleEntity article;

  const ExploreArticleItem({required this.article, this.height = 120.0, super.key});

  @override
  State<ExploreArticleItem> createState() => _ExploreArticleItemState();
}

class _ExploreArticleItemState extends State<ExploreArticleItem> {
  bool _pressed = false;

  void _setPressed(bool value) {
    setState(() {
      _pressed = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      scale: _pressed ? 1.07 : 1.0, // Slightly enlarge when pressed
      duration: const Duration(milliseconds: 120),
      curve: Curves.easeOut,
      child: AppSemantics(
        label: AppSemanticsLabels.exploreArticleItem,
        button: true,
        child: Material(
          color: AppColors.accentColor.withAlpha(60),
          borderRadius: BorderRadius.circular(AppDimensions.normalL),
          child: InkWell(
            onTap: () => context.go(AppRoutes.home + AppRoutes.articleDetails),
            onTapDown: (_) => _setPressed(true),
            onTapUp: (_) => _setPressed(false),
            onTapCancel: () => _setPressed(false),
            borderRadius: BorderRadius.circular(AppDimensions.normalL),
            child: Container(
              height: widget.height,
              width: 120,
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
                      imageUrl: widget.article.imageUrl ?? '',
                      fit: BoxFit.cover,
                      width: 120,
                      height: widget.height,
                      placeholder: (context, url) => Container(color: AppColors.placeholderColor),
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
                        widget.article.title,
                        maxLines: 2,
                        style: AppTextStyles.zonaPro16White,
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
  }
}
