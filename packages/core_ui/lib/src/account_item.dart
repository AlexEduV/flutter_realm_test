import 'package:flutter/material.dart';
import 'package:test_flutter_project/presentation/widgets/app_semantics.dart';
import 'package:test_flutter_project/presentation/widgets/skip_widget.dart';

class AccountItem extends StatelessWidget {
  const AccountItem({
    required this.label,
    required this.semanticsId,
    this.icon,
    this.onTap,
    this.textStyle,
    this.isCentered = false,
    super.key,
  });

  final IconData? icon;
  final String label;
  final TextStyle? textStyle;
  final void Function()? onTap;
  final bool isCentered;
  final String semanticsId;

  @override
  Widget build(BuildContext context) {
    return AppSemantics(
      label: '$semanticsId $label',
      child: ListTile(
        title: SkipWidget(
          skip: !isCentered,
          child: Center(child: Text(label, style: textStyle)),
        ),
        leading: (icon != null && !isCentered) ? Icon(icon) : null,
        onTap: onTap,
        tileColor: Colors.white,
        trailing: (onTap != null && !isCentered)
            ? const Icon(Icons.chevron_right_outlined, color: Colors.grey)
            : null,
      ),
    );
  }
}
