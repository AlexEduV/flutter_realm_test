import 'package:cached_network_image/cached_network_image.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:test_flutter_project/common/constants/app_semantics_labels.dart';
import 'package:test_flutter_project/presentation/features/account/widgets/user_avatar_enhanced.dart';
import 'package:test_flutter_project/presentation/widgets/app_semantics.dart';

class AvatarWidget extends StatelessWidget {
  const AvatarWidget({
    required this.imageSrc,
    this.size = AppDimensions.majorXL,
    this.isLocal = false,
    this.showPlaceholder = false,
    super.key,
  });

  final String? imageSrc;
  final double size;
  final bool isLocal;
  final bool showPlaceholder;

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
