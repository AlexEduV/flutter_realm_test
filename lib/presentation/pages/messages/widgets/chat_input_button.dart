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
      child: DecoratedBox(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: onTap != null
              ? [
                  BoxShadow(
                    color: Colors.black.withAlpha(25),
                    spreadRadius: 1,
                    blurRadius: 4,
                    offset: const Offset(0, 2), // changes position of shadow
                  ),
                ]
              : null,
        ),
        child: IconButton(
          onPressed: onTap,
          icon: Icon(icon),
          style: ButtonStyle(
            iconSize: const WidgetStatePropertyAll(AppDimensions.bottomMessageBarIconSize),
            foregroundColor: WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
              if (states.contains(WidgetState.disabled)) {
                return AppColors.lightGrey;
              }
              return AppColors.headerColor;
            }),
            backgroundColor: const WidgetStatePropertyAll(Colors.white),
          ),
        ),
      ),
    );
  }
}
