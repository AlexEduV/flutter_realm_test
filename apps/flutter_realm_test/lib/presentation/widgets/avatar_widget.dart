import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart'
    show BuildContext, BoxFit, StatelessWidget, Widget, ColoredBox, ClipOval, SizedBox;
import 'package:test_futter_project/common/constants/app_semantics_labels.dart';
import 'package:test_futter_project/presentation/pages/account/widgets/user_avatar_enhanced.dart';
import 'package:test_futter_project/presentation/widgets/app_semantics.dart';

import '../../common/constants/app_colors.dart';
import '../../common/constants/app_dimensions.dart';

class AvatarWidget extends StatelessWidget {
  final String? imageSrc;
  final double size;
  final bool isLocal;
  final bool showPlaceholder;

  const AvatarWidget({
    required this.imageSrc,
    this.size = AppDimensions.majorXL,
    this.isLocal = false,
    this.showPlaceholder = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (showPlaceholder) {
      return SizedBox(width: size, height: size);
    }

    if (isLocal) {
      return UserAvatarEnhanced(imageSrc: imageSrc, onTap: null, size: size, isDecorated: false);
    }

    return AppSemantics(
      label: AppSemanticsLabels.avatarWidget,
      child: ClipOval(
        child: CachedNetworkImage(
          imageUrl: imageSrc ?? '',
          fit: BoxFit.cover,
          height: size,
          width: size,
          placeholder: (context, url) => ColoredBox(color: AppColors.placeholderColor),
          errorWidget: (context, url, error) => ColoredBox(color: AppColors.placeholderColor),
        ),
      ),
    );
  }
}
