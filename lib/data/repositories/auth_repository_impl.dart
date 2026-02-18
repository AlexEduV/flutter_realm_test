import 'package:test_futter_project/domain/entities/user_entity_short.dart';
import 'package:test_futter_project/domain/models/auth_result.dart';
import 'package:test_futter_project/domain/repositories/auth_repository.dart';
import 'package:test_futter_project/mocks/mock_users.dart';
import 'package:test_futter_project/utils/auth_session_util.dart';
import 'package:test_futter_project/utils/l10n.dart';

class AuthRepositoryImpl implements AuthRepository {
  late final Map<String, UserEntityShort> users;

  void init() async {
    users = await MockUsers.loadMockUsers();
  }

  @override
  Future<void> logOut() async {
    await AuthSessionUtil.clearUserSession();
    await Future.delayed(const Duration(milliseconds: 200));
  }

  @override
  Future<AuthResult> login({required String email, required String password}) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 1500));

    if (!users.values.any((element) => element.email == email)) {
      return AuthResult(success: false, message: AppLocalisations.authErrorUserNotFoundMessage);
    }

    if (!users.values.any((element) => element.password == password && element.email == email)) {
      return AuthResult(success: false, message: AppLocalisations.authErrorIncorrectPassword);
    }

    await AuthSessionUtil.saveUserSession(
      users.values.firstWhere((element) => element.email == email).userId,
    );
    return AuthResult(success: true);
  }

  @override
  Future<AuthResult> register({
    required String email,
    required String password,
    required String fullName,
  }) async {
    await Future.delayed(const Duration(milliseconds: 1500));

    if (users.values.any((element) => element.email == email)) {
      return AuthResult(success: false, message: AppLocalisations.authErrorUserAlreadyExists);
    }

    final newUserId = users.length;
    users.addAll({
      '$newUserId': UserEntityShort(
        userId: '$newUserId',
        email: email,
        password: password,
        fullName: fullName,
      ),
    });
    await MockUsers.saveMockUsers(users);
    await AuthSessionUtil.saveUserSession(newUserId.toString());

    return AuthResult(success: true);
  }
}
