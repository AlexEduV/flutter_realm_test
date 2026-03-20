import 'package:flutter/material.dart';

import '../../../../common/app_colors.dart';
import '../../../../common/app_dimensions.dart';

class ChatInputButton extends StatelessWidget {
  final VoidCallback? onTap;
  final IconData icon;

  const ChatInputButton({required this.icon, this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    final buttonsBottomPadding = AppDimensions.minorS;

    return Padding(
      padding: EdgeInsets.only(bottom: buttonsBottomPadding),
      child: IconButton(
        onPressed: onTap,
        icon: Icon(icon),
        style: ButtonStyle(
          iconSize: const WidgetStatePropertyAll(AppDimensions.bottomMessageBarIconSize),
          foregroundColor: WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
            if (states.contains(WidgetState.disabled)) {
              return AppColors.lightGrey; // your disabled color here
            }
            return AppColors.headerColor; // default color
          }),
          backgroundColor: const WidgetStatePropertyAll(Colors.white),
        ),
      ),
    );
  }
}
