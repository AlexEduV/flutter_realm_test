import 'package:flutter/material.dart';
import 'package:test_futter_project/common/app_semantics_labels.dart';
import 'package:test_futter_project/presentation/widgets/app_semantics.dart';

class AccountItem extends StatelessWidget {
  final IconData? icon;
  final String text;
  final TextStyle? textStyle;
  final void Function()? onTap;
  final bool isCentered;

  const AccountItem({
    required this.text,
    this.icon,
    this.onTap,
    this.textStyle,
    this.isCentered = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final titleWidget = Text(text, style: textStyle);
    final textWidget = isCentered ? Center(child: titleWidget) : titleWidget;

    return AppSemantics(
      label: '${AppSemanticsLabels.accountItem} $text',
      child: ListTile(title: textWidget, leading: Icon(icon)),
    );
  }
}
