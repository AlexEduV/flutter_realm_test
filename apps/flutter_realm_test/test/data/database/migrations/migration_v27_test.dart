import 'package:flutter_test/flutter_test.dart';
import 'package:test_flutter_project/data/database/migrations/migration_v27.dart';

void main() {
  group('splitFullName', () {
    test('single word becomes firstName, lastName is empty', () {
      final result = splitFullName('John');
      expect(result.firstName, 'John');
      expect(result.lastName, '');
    });

    test('two words split into firstName and lastName', () {
      final result = splitFullName('John Doe');
      expect(result.firstName, 'John');
      expect(result.lastName, 'Doe');
    });

    test('everything after the first word is joined into lastName', () {
      final result = splitFullName('John Van Der Berg');
      expect(result.firstName, 'John');
      expect(result.lastName, 'Van Der Berg');
    });

    test('empty string produces two empty strings', () {
      final result = splitFullName('');
      expect(result.firstName, '');
      expect(result.lastName, '');
    });
  });
}
