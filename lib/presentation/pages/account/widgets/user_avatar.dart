import 'dart:io';

import 'package:flutter/material.dart';
import 'package:test_futter_project/presentation/pages/home/home_bottom_bar/widgets/animated_add_button.dart';

import '../../../../common/app_colors.dart';
import '../../../../common/app_dimensions.dart';

class UserAvatar extends StatelessWidget {
  final String? imageSrc;
  final Function() onTap;

  const UserAvatar({required this.imageSrc, required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: AppDimensions.minorL),
      child: Center(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            CircleAvatar(
              radius: AppDimensions.avatarImageSize,
              backgroundImage: (imageSrc != null && imageSrc!.isNotEmpty)
                  ? FileImage(File(imageSrc!))
                  : null,
              backgroundColor: imageSrc == null || imageSrc!.isEmpty
                  ? AppColors.placeholderColor
                  : null,
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: AnimatedAddButton(
                onPressed: onTap,
                backgroundColor: AppColors.accentColor,
                size: AppDimensions.avatarImageAddIconSize,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
