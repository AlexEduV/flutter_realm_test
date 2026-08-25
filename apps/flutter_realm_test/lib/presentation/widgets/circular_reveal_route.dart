import 'dart:math';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class _CircularRevealClipper extends CustomClipper<Path> {
  const _CircularRevealClipper({required this.fraction, required this.center});

  final double fraction;
  final Offset center;

  @override
  Path getClip(Size size) {
    final maxRadius = sqrt(
      pow(max(center.dx, size.width - center.dx), 2) +
          pow(max(center.dy, size.height - center.dy), 2),
    );
    return Path()..addOval(Rect.fromCircle(center: center, radius: maxRadius * fraction));
  }

  @override
  bool shouldReclip(_CircularRevealClipper oldClipper) {
    return oldClipper.fraction != fraction || oldClipper.center != center;
  }
}

Page<T> circularRevealPage<T>({required Widget child, Offset? origin}) {
  return CustomTransitionPage<T>(
    child: child,
    transitionDuration: const Duration(milliseconds: 480),
    reverseTransitionDuration: const Duration(milliseconds: 320),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final center = origin ?? MediaQuery.sizeOf(context).center(Offset.zero);
      final curved = CurvedAnimation(parent: animation, curve: Curves.easeInOut);
      return AnimatedBuilder(
        animation: curved,
        builder: (_, __) => ClipPath(
          clipper: _CircularRevealClipper(fraction: curved.value, center: center),
          child: child,
        ),
      );
    },
  );
}
