import 'package:flutter_test/flutter_test.dart';
import 'package:test_futter_project/utils/json_util.dart';

void main() {
  group('JsonUtil.flattenJson', () {
    test('flattens a simple flat map', () {
      final input = {'a': '1', 'b': '2'};
      final expected = {'a': '1', 'b': '2'};

      final result = JsonUtil.flattenJson(input);

      expect(result, expected);
    });

    test('flattens a nested map', () {
      final input = {
        'a': {'b': '2', 'c': '3'},
        'd': '4',
      };
      final expected = {'a.b': '2', 'a.c': '3', 'd': '4'};

      final result = JsonUtil.flattenJson(input);

      expect(result, expected);
    });

    test('flattens a deeply nested map', () {
      final input = {
        'a': {
          'b': {'c': '3'},
        },
        'd': '4',
      };
      final expected = {'a.b.c': '3', 'd': '4'};

      final result = JsonUtil.flattenJson(input);

      expect(result, expected);
    });

    test('handles non-string values', () {
      final input = {
        'a': 1,
        'b': {'c': true, 'd': null},
      };
      final expected = {'a': '1', 'b.c': 'true', 'b.d': 'null'};

      final result = JsonUtil.flattenJson(input);

      expect(result, expected);
    });

    test('handles empty map', () {
      final input = <String, dynamic>{};
      final expected = <String, String>{};

      final result = JsonUtil.flattenJson(input);

      expect(result, expected);
    });
  });
}
