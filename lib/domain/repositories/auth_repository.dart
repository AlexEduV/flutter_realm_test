import 'package:test_futter_project/domain/models/auth_result.dart';

abstract class AuthRepository {
  Future<void> init();

  Future<AuthResult> login({required String email, required String password});

  Future<AuthResult> register({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  });

  Future<void> logOut();

  Future<void> deleteAccount(String email);
}
