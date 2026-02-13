import 'package:flutter_test/flutter_test.dart';
import 'package:test_futter_project/common/extensions/string_extension.dart';

void main() {
  group('StringCasingExtension.capitalizeFirst', () {
    test('capitalizes the first letter of a lowercase word', () {
      expect('hello'.capitalizeFirst(), 'Hello');
    });

    test('capitalizes the first letter of an uppercase word', () {
      expect('Hello'.capitalizeFirst(), 'Hello');
    });

    test('returns empty string if input is empty', () {
      expect(''.capitalizeFirst(), '');
    });

    test('works with single character', () {
      expect('h'.capitalizeFirst(), 'H');
    });

    test('does not change the rest of the string', () {
      expect('hELLO'.capitalizeFirst(), 'HELLO');
    });

    test('works with strings starting with whitespace', () {
      expect(' hello'.capitalizeFirst(), ' hello');
    });

    test('works with non-letter first character', () {
      expect('1hello'.capitalizeFirst(), '1hello');
    });
  });
}
