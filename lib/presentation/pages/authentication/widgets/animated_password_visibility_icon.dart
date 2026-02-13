import 'package:flutter/material.dart';
import 'package:test_futter_project/common/app_colors.dart';
import 'package:test_futter_project/common/app_dimensions.dart';

class AnimatedVisibilityIcon extends StatefulWidget {
  final bool isObscure;
  final Duration duration;

  const AnimatedVisibilityIcon({
    required this.isObscure,
    this.duration = const Duration(milliseconds: 200),
    super.key,
  });

  @override
  State<AnimatedVisibilityIcon> createState() => _AnimatedVisibilityIconState();
}

class _AnimatedVisibilityIconState extends State<AnimatedVisibilityIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void didUpdateWidget(covariant AnimatedVisibilityIcon oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isObscure != oldWidget.isObscure) {
      if (widget.isObscure) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
      value: widget.isObscure ? 1.0 : 0.0,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        const Icon(Icons.visibility, size: AppDimensions.normalXL, color: AppColors.headerColor),
        AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return CustomPaint(
              size: const Size(AppDimensions.normalXL, AppDimensions.normalXL),
              painter: _LinePainter(progress: _controller.value),
            );
          },
        ),
      ],
    );
  }
}

class _LinePainter extends CustomPainter {
  final double progress; // 0.0 = not drawn, 1.0 = fully drawn

  _LinePainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    if (progress == 0.0) return;

    final paint = Paint()
      ..color = AppColors.headerColor.withAlpha((progress * 255).round())
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round;

    final center = Offset(size.width / 2, size.height / 2);

    // Define the two directions for the line (diagonal)
    final offset1 = Offset(size.width - 4, size.height - 4); // bottom-right
    final offset2 = const Offset(4, 4); // top-left

    // Animate from center to both ends
    final current1 = Offset.lerp(center, offset1, progress)!;
    final current2 = Offset.lerp(center, offset2, progress)!;

    canvas.drawLine(center, current1, paint);
    canvas.drawLine(center, current2, paint);
  }

  @override
  bool shouldRepaint(_LinePainter oldDelegate) => oldDelegate.progress != progress;
}
