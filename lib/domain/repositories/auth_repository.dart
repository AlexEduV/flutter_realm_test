import 'package:test_futter_project/domain/models/auth_result.dart';

abstract class AuthRepository {
  Future<AuthResult> login(String email, String password);

  Future<AuthResult> register(String email, String password);

  Future<void> logOut();
}
