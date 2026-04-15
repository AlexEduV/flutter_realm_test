import 'package:flutter_test/flutter_test.dart';
import 'package:test_flutter_project/domain/models/auth_result.dart';

void main() {
  group('AuthResult', () {
    test('constructor assigns values correctly with message', () {
      final result = AuthResult(success: true, message: 'Welcome!');
      expect(result.success, isTrue);
      expect(result.message, 'Welcome!');
    });

    test('constructor assigns values correctly without message', () {
      final result = AuthResult(success: false);
      expect(result.success, isFalse);
      expect(result.message, isNull);
    });

    test('equality and hashCode: identical objects', () {
      final r1 = AuthResult(success: true, message: 'msg');
      final r2 = AuthResult(success: true, message: 'msg');
      expect(r1, r2);
      expect(r1.hashCode, r2.hashCode);
    });

    test('equality and hashCode: different objects', () {
      final r1 = AuthResult(success: true, message: 'msg');
      final r2 = AuthResult(success: false, message: 'msg');
      final r3 = AuthResult(success: true, message: 'other');
      expect(r1 == r2, isFalse);
      expect(r1 == r3, isFalse);
      expect(r1.hashCode == r2.hashCode, isFalse);
      expect(r1.hashCode == r3.hashCode, isFalse);
    });

    test('equality and hashCode: null message', () {
      final r1 = AuthResult(success: true);
      final r2 = AuthResult(success: true, message: null);
      expect(r1, r2);
      expect(r1.hashCode, r2.hashCode);
    });
  });
}
