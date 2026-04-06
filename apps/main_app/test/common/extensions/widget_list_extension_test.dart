import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_futter_project/common/extensions/widget_list_extension.dart';

void main() {
  group('WidgetListDividers', () {
    test('withDividers returns empty list for empty input', () {
      final widgets = <Widget>[];
      final result = widgets.withDividers();
      expect(result, isEmpty);
    });

    test('withDividers returns same list for single widget', () {
      final widgets = [const Text('A')];
      final result = widgets.withDividers();
      expect(result.length, 1);
      expect(result.first, isA<Text>());
      expect((result.first as Text).data, 'A');
    });

    test('withDividers interleaves default Divider between widgets', () {
      final widgets = [const Text('A'), const Text('B'), const Text('C')];
      final result = widgets.withDividers();

      // Should be: Text('A'), Divider, Text('B'), Divider, Text('C')
      expect(result.length, 5);
      expect(result[0], isA<Text>());
      expect(result[1], isA<Divider>());
      expect(result[2], isA<Text>());
      expect(result[3], isA<Divider>());
      expect(result[4], isA<Text>());
      expect((result[0] as Text).data, 'A');
      expect((result[2] as Text).data, 'B');
      expect((result[4] as Text).data, 'C');
    });

    test('withDividers uses custom divider', () {
      final widgets = [const Text('A'), const Text('B')];
      final customDivider = const Divider(height: 10, color: Colors.red);
      final result = widgets.withDividers(divider: customDivider);

      expect(result.length, 3);
      expect(result[1], customDivider);
    });

    test('withDividers does not add divider after last widget', () {
      final widgets = [const Text('A'), const Text('B')];
      final result = widgets.withDividers();
      expect(result.last, isA<Text>());
      expect((result.last as Text).data, 'B');
    });
  });
}
