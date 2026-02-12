import 'package:test_futter_project/domain/models/auth_result.dart';

abstract class AuthService {
  Future<AuthResult> login(String email, String password);

  Future<AuthResult> register(String email, String password, String fullName);

  void changePassword(String oldPassword, String newPassword);

  void logOut();
}
