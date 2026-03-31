import 'package:flutter/material.dart';

class ColorItem extends StatelessWidget {
  final Color color;
  final bool isPicked;
  final VoidCallback onTap;

  const ColorItem({required this.color, required this.isPicked, required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(120.0),
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
          border: Border.all(
            color: Color.alphaBlend(Colors.black.withAlpha(50), color),
            width: 2.0,
          ),
        ),
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          opacity: isPicked ? 1.0 : 0.0,
          child: const Icon(Icons.done, color: Colors.black),
        ),
      ),
    );
  }
}
