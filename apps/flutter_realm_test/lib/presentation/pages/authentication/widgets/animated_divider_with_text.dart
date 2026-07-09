import 'package:flutter/material.dart';
import 'package:core_ui/core_ui.dart';

class AnimatedDividerWithText extends StatefulWidget {
  const AnimatedDividerWithText({
    required this.text,
    this.duration = const Duration(seconds: 1),
    super.key,
  });

  final String text;
  final Duration duration;

  @override
  State<AnimatedDividerWithText> createState() => _AnimatedDividerWithTextState();
}

class _AnimatedDividerWithTextState extends State<AnimatedDividerWithText>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: widget.duration, vsync: this);
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppDimensions.normalM),
      child: Row(
        children: <Widget>[
          Expanded(
            child: AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return FractionallySizedBox(
                  alignment: Alignment.centerRight,
                  widthFactor: _animation.value,
                  child: const Divider(thickness: 1),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppDimensions.minorL),
            child: Text(widget.text),
          ),
          Expanded(
            child: AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: _animation.value,
                  child: const Divider(thickness: 1),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
