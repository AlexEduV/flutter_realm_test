import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart'
    show BuildContext, BoxFit, StatelessWidget, Widget, ColoredBox, ClipOval;

import '../../common/app_colors.dart';
import '../../common/app_dimensions.dart';

class AvatarWidget extends StatelessWidget {
  final String? imageSrc;
  final double? size;

  const AvatarWidget({
    required this.imageSrc,
    this.size = AppDimensions.authorImageSize,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: CachedNetworkImage(
        imageUrl: imageSrc ?? '',
        fit: BoxFit.cover,
        height: size,
        width: size,
        placeholder: (context, url) => ColoredBox(color: AppColors.placeholderColor),
        errorWidget: (context, url, error) => ColoredBox(color: AppColors.placeholderColor),
      ),
    );
  }
}
