import 'dart:io';

import 'package:flutter/material.dart';

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
              radius: 50,
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
              child: Material(
                color: AppColors.accentColor,
                shape: const CircleBorder(),
                child: InkWell(
                  onTap: onTap,
                  customBorder: const CircleBorder(),
                  child: const CircleAvatar(
                    radius: 17,
                    backgroundColor: Colors.transparent,
                    child: Icon(Icons.add, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
