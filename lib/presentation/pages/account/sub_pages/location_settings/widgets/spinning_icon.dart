import 'package:flutter/material.dart';

class SpinningIcon extends StatefulWidget {
  final bool spin;
  final IconData icon;

  const SpinningIcon({required this.spin, required this.icon, super.key});

  @override
  State<SpinningIcon> createState() => _SpinningIconState();
}

class _SpinningIconState extends State<SpinningIcon> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: const Duration(milliseconds: 600), vsync: this);
  }

  @override
  void didUpdateWidget(SpinningIcon oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.spin && !oldWidget.spin) {
      _controller.forward(from: 0.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(turns: _controller, child: Icon(widget.icon));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
