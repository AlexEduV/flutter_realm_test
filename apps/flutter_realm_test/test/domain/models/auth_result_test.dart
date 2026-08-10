import 'package:flutter_test/flutter_test.dart';
import 'package:test_flutter_project/domain/models/auth_error_code.dart';
import 'package:test_flutter_project/domain/models/auth_result.dart';

void main() {
  group('AuthResult', () {
    test('constructor assigns values correctly with errorCode', () {
      final result = AuthResult(success: false, errorCode: AuthErrorCode.userNotFound);
      expect(result.success, isFalse);
      expect(result.errorCode, AuthErrorCode.userNotFound);
    });

    test('constructor assigns values correctly without errorCode', () {
      final result = AuthResult(success: false);
      expect(result.success, isFalse);
      expect(result.errorCode, isNull);
    });

    test('equality and hashCode: identical objects', () {
      final r1 = AuthResult(success: false, errorCode: AuthErrorCode.userNotFound);
      final r2 = AuthResult(success: false, errorCode: AuthErrorCode.userNotFound);
      expect(r1, r2);
      expect(r1.hashCode, r2.hashCode);
    });

    test('equality and hashCode: different objects', () {
      final r1 = AuthResult(success: false, errorCode: AuthErrorCode.userNotFound);
      final r2 = AuthResult(success: false, errorCode: AuthErrorCode.incorrectPassword);
      final r3 = AuthResult(success: true);
      expect(r1 == r2, isFalse);
      expect(r1 == r3, isFalse);
      expect(r1.hashCode == r2.hashCode, isFalse);
    });

    test('equality and hashCode: null errorCode', () {
      final r1 = AuthResult(success: true);
      final r2 = AuthResult(success: true, errorCode: null);
      expect(r1, r2);
      expect(r1.hashCode, r2.hashCode);
    });
  });
}
