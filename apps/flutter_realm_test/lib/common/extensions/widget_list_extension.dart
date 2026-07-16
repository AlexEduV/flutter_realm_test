import 'package:flutter/material.dart' show Widget, Divider;

extension WidgetListDividers on List<Widget> {
  List<Widget> _interleaveDividers({Widget? divider}) {
    final List<Widget> result = [];
    for (int i = 0; i < length; i++) {
      result.add(this[i]);
      if (i < length - 1) {
        result.add(divider ?? const Divider(height: 1));
      }
    }
    return result;
  }

  List<Widget> withDividers({Widget? divider}) => _interleaveDividers(divider: divider);
}
