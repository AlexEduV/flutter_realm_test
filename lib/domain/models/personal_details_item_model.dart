import 'package:flutter/cupertino.dart' show IconData;

class PersonalDetailsItemModel {
  final String title;
  final String subtitle;
  final IconData icon;
  final bool? showEnabled;
  final Function()? onTap;

  PersonalDetailsItemModel({
    required this.title,
    required this.subtitle,
    required this.icon,
    this.showEnabled,
    this.onTap,
  });
}
