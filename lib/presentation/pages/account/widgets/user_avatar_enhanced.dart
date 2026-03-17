import 'dart:io';

import 'package:flutter/material.dart';
import 'package:test_futter_project/common/app_semantics_labels.dart';
import 'package:test_futter_project/presentation/pages/home/home_bottom_bar/widgets/animated_add_button.dart';
import 'package:test_futter_project/presentation/widgets/app_semantics.dart';

import '../../../../common/app_colors.dart';
import '../../../../common/app_dimensions.dart';

class UserAvatarEnhanced extends StatelessWidget {
  final String? imageSrc;
  final Function()? onTap;
  final double size;
  final bool isDecorated;

  const UserAvatarEnhanced({
    required this.imageSrc,
    required this.onTap,
    this.size = AppDimensions.avatarImageSize * 2,
    this.isDecorated = true,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: AppDimensions.minorL),
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
                      border: Border.all(
                        color: Colors.white, // Set your desired border color
                        width: 3.0, // Set your desired border width
                      ),
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
                  label: AppSemanticsLabels.avatarSetImageButton,
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
