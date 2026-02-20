import 'package:test_futter_project/domain/data_sources/base_local_storage.dart';
import 'package:test_futter_project/domain/entities/user_entity_short.dart';
import 'package:test_futter_project/domain/models/auth_result.dart';
import 'package:test_futter_project/domain/repositories/auth_repository.dart';
import 'package:test_futter_project/mocks/mock_users.dart';
import 'package:test_futter_project/utils/auth_session_util.dart';
import 'package:test_futter_project/utils/l10n.dart';

import '../../common/extensions/user_scheme_extension.dart';

class AuthRepositoryImpl implements AuthRepository {
  final BaseLocalStorage _localStorage;

  AuthRepositoryImpl(this._localStorage);

  late final Map<String, UserEntityShort> users;

  @override
  Future<void> init() async {
    users = await MockUsers.loadMockUsers();
  }

  @override
  Future<void> logOut() async {
    await AuthSessionUtil.clearUserSession();
    _localStorage.clearUser();
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

    final user = users.values.firstWhere((element) => element.email == email);

    await AuthSessionUtil.saveUserSession(user.userId);
    _localStorage.update(UserExtensions.fromUserEntityShort(user));

    return AuthResult(success: true);
  }

  @override
  Future<AuthResult> register({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  }) async {
    await Future.delayed(const Duration(milliseconds: 1500));

    if (users.values.any((element) => element.email == email)) {
      return AuthResult(success: false, message: AppLocalisations.authErrorUserAlreadyExists);
    }

    final newUserId = users.length;
    final user = UserEntityShort(
      userId: '$newUserId',
      email: email,
      password: password,
      firstName: firstName,
      lastName: lastName,
    );

    users.addAll({'$newUserId': user});
    await MockUsers.saveMockUsers(users);
    await AuthSessionUtil.saveUserSession(newUserId.toString());
    _localStorage.update(UserExtensions.fromUserEntityShort(user));

    return AuthResult(success: true);
  }

  @override
  Future<void> deleteAccount(String email) async {
    await logOut();

    users.removeWhere((elementId, element) => element.email == email);
    await MockUsers.saveMockUsers(users);
  }
}
