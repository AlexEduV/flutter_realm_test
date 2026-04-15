import 'package:test_flutter_project/domain/models/auth_result.dart';

abstract class AuthRemoteDataSource {
  Future<AuthResult> login(String email, String password);

  Future<AuthResult> register(String email, String password, String firstName, String lastName);

  void changePassword(String oldPassword, String newPassword);

  void logOut();

  void deleteAccount(String email);
}
