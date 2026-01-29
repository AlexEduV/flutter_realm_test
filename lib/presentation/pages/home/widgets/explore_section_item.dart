import 'package:flutter/material.dart';

class ExploreSectionItem extends StatelessWidget {
  final double height;

  const ExploreSectionItem({super.key, this.height = 120.0});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6 * 2),
        color: Colors.grey[300],
      ),
      height: height,
      width: 120,
    );
  }
}
