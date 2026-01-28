import 'package:flutter/material.dart';

class ExploreSectionItem extends StatelessWidget {
  final double size;

  const ExploreSectionItem({super.key, this.size = 120.0});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6 * 2),
        color: Colors.grey[300],
      ),
      height: size,
      width: size,
    );
  }
}
