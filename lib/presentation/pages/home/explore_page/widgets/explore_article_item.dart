import 'package:flutter/material.dart';
import 'package:test_futter_project/common/app_dimensions.dart';
import 'package:test_futter_project/common/app_semantics_labels.dart';
import 'package:test_futter_project/common/app_text_styles.dart';
import 'package:test_futter_project/presentation/widgets/app_semantics.dart';

import '../../../../../common/app_colors.dart';

class ExploreArticleItem extends StatefulWidget {
  final double height;
  final String articleName;

  const ExploreArticleItem({required this.articleName, this.height = 120.0, super.key});

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
            onTap: () {
              // Your tap logic here
            },
            onTapDown: (_) => _setPressed(true),
            onTapUp: (_) => _setPressed(false),
            onTapCancel: () => _setPressed(false),
            borderRadius: BorderRadius.circular(AppDimensions.normalL),
            child: Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(AppDimensions.normalL)),
              height: widget.height,
              width: 120,
              child: Padding(
                padding: const EdgeInsets.all(AppDimensions.minorL),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(widget.articleName, maxLines: 2, style: AppTextStyles.zonaPro16White),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
