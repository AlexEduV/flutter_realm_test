import 'package:test_flutter_project/domain/models/auth_error_code.dart';

sealed class AuthResult {
  const AuthResult();
}

final class AuthSuccess extends AuthResult {
  const AuthSuccess();

  @override
  bool operator ==(Object other) => other is AuthSuccess;

  @override
  int get hashCode => runtimeType.hashCode;
}

final class AuthFailure extends AuthResult {
  const AuthFailure(this.errorCode);

  final AuthErrorCode errorCode;

  @override
  bool operator ==(Object other) => other is AuthFailure && errorCode == other.errorCode;

  @override
  int get hashCode => errorCode.hashCode;
}
