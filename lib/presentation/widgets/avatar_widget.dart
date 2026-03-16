import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart'
    show BuildContext, BoxFit, StatelessWidget, Widget, ColoredBox, ClipOval;

import '../../common/app_colors.dart';
import '../../common/app_dimensions.dart';

class AvatarWidget extends StatelessWidget {
  final String? imageSrc;

  const AvatarWidget({required this.imageSrc, super.key});

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: CachedNetworkImage(
        imageUrl: imageSrc ?? '',
        fit: BoxFit.cover,
        height: AppDimensions.authorImageSize,
        width: AppDimensions.authorImageSize,
        placeholder: (context, url) => ColoredBox(color: AppColors.placeholderColor),
        errorWidget: (context, url, error) => ColoredBox(color: AppColors.placeholderColor),
      ),
    );
  }
}
