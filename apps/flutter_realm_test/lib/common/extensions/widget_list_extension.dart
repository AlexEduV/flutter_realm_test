import 'package:flutter/material.dart' show Widget, Divider;

extension WidgetListDividers on List<Widget> {
  List<Widget> _interleaveDividers({Widget? divider}) {
    if (isEmpty) return [];

    final separator = divider ?? const Divider(height: 1);
    final result = List<Widget>.filled(length * 2 - 1, separator);
    for (int i = 0; i < length; i++) {
      result[i * 2] = this[i];
    }
    return result;
  }

  List<Widget> withDividers({Widget? divider}) =>
      _interleaveDividers(divider: divider);
}
