import 'package:flutter_test/flutter_test.dart';
import 'package:test_flutter_project/common/enums/auth_error_code.dart';
import 'package:test_flutter_project/domain/models/auth_result.dart';

void main() {
  group('AuthSuccess', () {
    test('two instances are equal', () {
      expect(const AuthSuccess(), const AuthSuccess());
      expect(const AuthSuccess().hashCode, const AuthSuccess().hashCode);
    });

    test('is not equal to AuthFailure', () {
      expect(const AuthSuccess() == const AuthFailure(AuthErrorCode.userNotFound), isFalse);
    });
  });

  group('AuthFailure', () {
    test('holds the error code', () {
      final result = const AuthFailure(AuthErrorCode.userNotFound);
      expect(result.errorCode, AuthErrorCode.userNotFound);
    });

    test('equality: same error code', () {
      expect(
        const AuthFailure(AuthErrorCode.userNotFound),
        const AuthFailure(AuthErrorCode.userNotFound),
      );
    });

    test('equality: different error codes', () {
      expect(
        const AuthFailure(AuthErrorCode.userNotFound) ==
            const AuthFailure(AuthErrorCode.incorrectPassword),
        isFalse,
      );
    });

    test('hashCode differs for different error codes', () {
      expect(
        const AuthFailure(AuthErrorCode.userNotFound).hashCode ==
            const AuthFailure(AuthErrorCode.incorrectPassword).hashCode,
        isFalse,
      );
    });
  });
}
