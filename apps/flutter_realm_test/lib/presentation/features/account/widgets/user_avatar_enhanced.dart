import 'dart:io';

import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:test_flutter_project/common/constants/app_semantics_labels.dart';
import 'package:test_flutter_project/presentation/widgets/app_semantics.dart';

import '../../home_bottom_bar/widgets/animated_add_button.dart';
import '../account_page_identifiers.dart';

class UserAvatarEnhanced extends StatelessWidget {
  const UserAvatarEnhanced({
    required this.imageSrc,
    required this.onTap,
    this.size = AppDimensions.avatarImageSize * 2,
    this.isDecorated = true,
    super.key,
  });

  final String? imageSrc;
  final Function()? onTap;
  final double size;
  final bool isDecorated;

  @override
  Widget build(BuildContext context) {
    return AppSemantics(
      label: AppSemanticsLabels.avatarWidgetEnhanced,
      child: Center(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: size,
              height: size,
              decoration: isDecorated
                  ? BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 3.0),
                    )
                  : null,
              child: CircleAvatar(
                radius: size / 2,
                backgroundImage: (imageSrc != null && imageSrc!.isNotEmpty)
                    ? FileImage(File(imageSrc!))
                    : null,
                backgroundColor: imageSrc == null || imageSrc!.isEmpty
                    ? AppColors.placeholderColor
                    : null,
              ),
            ),

            if (onTap != null) ...[
              Positioned(
                bottom: 0,
                right: 0,
                child: AppSemantics(
                  button: true,
                  label: AccountPageIds.avatarSetImageButton,
                  child: AnimatedAddButton(
                    onPressed: onTap,
                    backgroundColor: AppColors.accentColor,
                    size: AppDimensions.avatarImageAddIconSize,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
