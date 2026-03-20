import 'package:flutter/material.dart';
import 'package:test_futter_project/common/extensions/num_extension.dart';
import 'package:test_futter_project/presentation/widgets/app_semantics.dart';

import '../../../../common/app_colors.dart';
import '../../../../common/app_dimensions.dart';

class ChatInputButton extends StatefulWidget {
  final VoidCallback? onTap;
  final IconData icon;
  final double iconRotationAngleDegrees;
  final String semanticsLabel;

  const ChatInputButton({
    required this.icon,
    this.onTap,
    this.iconRotationAngleDegrees = 0.0,
    this.semanticsLabel = '',
    super.key,
  });

  @override
  State<ChatInputButton> createState() => _ChatInputButtonState();
}

class _ChatInputButtonState extends State<ChatInputButton> {
  double _scale = 1.0;

  @override
  Widget build(BuildContext context) {
    final buttonsBottomPadding = AppDimensions.minorS;

    return AnimatedScale(
      duration: const Duration(milliseconds: 300),
      scale: _scale,
      curve: Curves.easeInOut,
      child: Padding(
        padding: EdgeInsets.only(bottom: buttonsBottomPadding),
        child: DecoratedBox(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: widget.onTap != null
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
          child: AppSemantics(
            label: widget.semanticsLabel,
            button: true,
            enabled: widget.onTap != null,
            child: IconButton(
              onPressed: widget.onTap != null
                  ? () async {
                      widget.onTap?.call();
                      await animateOnTap();
                    }
                  : null,
              icon: Transform.rotate(
                angle: widget.iconRotationAngleDegrees.toRadians,
                child: Icon(widget.icon),
              ),
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
        ),
      ),
    );
  }

  Future<void> animateOnTap() async {
    setState(() => _scale = 1.5);
    await Future.delayed(const Duration(milliseconds: 100));
    setState(() => _scale = 1.0);
  }
}
