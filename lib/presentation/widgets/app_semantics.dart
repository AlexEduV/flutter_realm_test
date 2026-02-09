import 'package:flutter/cupertino.dart';

class AppSemantics extends StatelessWidget {
  final String label;
  final bool? isSelected;
  final bool? button;
  final bool? enabled;
  final bool? isChecked;

  final Widget child;

  const AppSemantics({
    required this.label,
    required this.child,
    this.isSelected,
    this.isChecked,
    this.button,
    this.enabled,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MergeSemantics(
      child: Semantics(
        label: label,
        button: button,
        selected: isSelected,
        checked: isChecked,
        child: child,
      ),
    );
  }
}
