import 'package:flutter/material.dart' show Widget, Divider;

extension WidgetListDividers on List<Widget> {
  List<Widget> _interleaveDividers(List<Widget> items, {Widget? divider}) {
    final List<Widget> result = [];
    for (int i = 0; i < items.length; i++) {
      result.add(items[i]);
      if (i < items.length - 1) {
        result.add(divider ?? const Divider(height: 1));
      }
    }
    return result;
  }

  List<Widget> withDividers({Widget? divider}) => _interleaveDividers(this, divider: divider);
}
