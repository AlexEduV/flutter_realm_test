import 'package:test_flutter_project/domain/models/auth_error_code.dart';

class AuthResult {
  AuthResult({required this.success, this.errorCode});

  final bool success;
  final AuthErrorCode? errorCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuthResult &&
          runtimeType == other.runtimeType &&
          success == other.success &&
          errorCode == other.errorCode;

  @override
  int get hashCode => success.hashCode ^ (errorCode?.hashCode ?? 0);
}
