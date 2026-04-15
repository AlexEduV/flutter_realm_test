import 'package:flutter_test/flutter_test.dart';
import 'package:test_flutter_project/common/extensions/list_extension.dart';

void main() {
  group('IndexOrNullExtension', () {
    test('returns correct index when element matches', () {
      final list = [1, 2, 3, 4];
      final index = list.indexWhereOrNull((e) => e == 3);
      expect(index, 2);
    });

    test('returns null when no element matches', () {
      final list = [1, 2, 3, 4];
      final index = list.indexWhereOrNull((e) => e == 5);
      expect(index, isNull);
    });

    test('returns null for empty list', () {
      final list = <int>[];
      final index = list.indexWhereOrNull((e) => e == 1);
      expect(index, isNull);
    });

    test('works with List<String>', () {
      final list = ['a', 'b', 'c'];
      final index = list.indexWhereOrNull((e) => e == 'b');
      expect(index, 1);
    });

    test('returns null if test always false', () {
      final list = [10, 20, 30];
      final index = list.indexWhereOrNull((e) => false);
      expect(index, isNull);
    });

    test('returns 0 if first element matches', () {
      final list = [5, 6, 7];
      final index = list.indexWhereOrNull((e) => e == 5);
      expect(index, 0);
    });
  });
}
