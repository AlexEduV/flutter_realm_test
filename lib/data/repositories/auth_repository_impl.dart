import 'package:test_futter_project/domain/models/auth_result.dart';
import 'package:test_futter_project/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final Map<String, String> _users = {
    'user@example.com': 'Password1!',
    'admin@example.com': 'AdminPass123!',
  };

  @override
  Future<void> logOut() async {
    await Future.delayed(const Duration(milliseconds: 200));
  }

  @override
  Future<AuthResult> login(String email, String password) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 1500));

    if (!_users.containsKey(email)) {
      return AuthResult(success: false, message: 'User not found');
    }
    if (_users[email] != password) {
      return AuthResult(success: false, message: 'Incorrect password');
    }
    return AuthResult(success: true);
  }

  @override
  Future<AuthResult> register(String email, String password) async {
    await Future.delayed(const Duration(milliseconds: 500));

    if (_users.containsKey(email)) {
      return AuthResult(success: false, message: 'User already exists');
    }
    _users[email] = password;
    return AuthResult(success: true);
  }
}
