import 'package:test_futter_project/domain/entities/user_entity_short.dart';
import 'package:test_futter_project/domain/models/auth_result.dart';
import 'package:test_futter_project/domain/repositories/auth_repository.dart';
import 'package:test_futter_project/utils/l10n.dart';

class AuthRepositoryImpl implements AuthRepository {
  //todo: move this to a secure mock
  final Map<String, UserEntityShort> _users = {
    '1': const UserEntityShort(
      userId: '1',
      email: 'mock@example.com',
      password: 'Password1!',
      fullName: 'user',
    ),
    '2': const UserEntityShort(
      userId: '2',
      email: 'admin@example.com',
      password: 'AdminPass123!',
      fullName: 'admin',
    ),
  };

  @override
  Future<void> logOut() async {
    await Future.delayed(const Duration(milliseconds: 200));
  }

  @override
  Future<AuthResult> login({required String email, required String password}) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 1500));

    if (!_users.values.any((element) => element.email == email)) {
      return AuthResult(success: false, message: AppLocalisations.authErrorUserNotFoundMessage);
    }

    if (!_users.values.any((element) => element.password == password && element.email == email)) {
      return AuthResult(success: false, message: AppLocalisations.authErrorIncorrectPassword);
    }

    return AuthResult(success: true);
  }

  @override
  Future<AuthResult> register({
    required String email,
    required String password,
    required String fullName,
  }) async {
    await Future.delayed(const Duration(milliseconds: 1500));

    if (_users.values.any((element) => element.email == email)) {
      return AuthResult(success: false, message: AppLocalisations.authErrorUserAlreadyExists);
    }

    final newUserId = _users.length;
    _users.addAll({
      '$newUserId': UserEntityShort(
        userId: '$newUserId',
        email: email,
        password: password,
        fullName: fullName,
      ),
    });

    return AuthResult(success: true);
  }
}
