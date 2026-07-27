import 'package:flutter/widgets.dart';

class AppSemantics extends StatelessWidget {
  const AppSemantics({
    required this.label,
    required this.child,
    this.isSelected,
    this.isChecked,
    this.button,
    this.enabled,
    this.textField,
    this.expanded,
    super.key,
  });

  final String label;
  final bool? isSelected;
  final bool? button;
  final bool? enabled;
  final bool? isChecked;
  final bool? textField;
  final bool? expanded;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      container: true,
      label: label,
      textField: textField,
      button: button,
      selected: isSelected,
      checked: isChecked,
      expanded: expanded,
      enabled: enabled,
      child: child,
    );
  }
}
