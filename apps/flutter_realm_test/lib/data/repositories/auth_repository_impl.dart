import 'dart:convert';
import 'dart:math';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_flutter_project/domain/data_sources/local/base_local_storage.dart';
import 'package:test_flutter_project/domain/models/auth_result.dart';
import 'package:test_flutter_project/domain/repositories/auth_repository.dart';
import 'package:test_flutter_project/domain/usecases/owners/fetch_owners_use_case.dart';
import 'package:test_flutter_project/domain/usecases/users/get_max_user_id_use_case.dart';
import 'package:test_flutter_project/domain/usecases/users/load_users_use_case.dart';
import 'package:test_flutter_project/domain/usecases/users/save_users_use_case.dart';
import 'package:test_flutter_project/l10n/l10n_keys.dart';
import 'package:test_flutter_project/presentation/bloc/l10n/app_localisations_cubit.dart';

import '../../common/extensions/user_scheme_extension.dart';
import '../../core/di/injection_container.dart';
import '../../domain/data_sources/remote/users_remote_data_source.dart';
import '../../domain/entities/session_entity.dart';
import '../../domain/entities/user_entity.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._localStorage, this._cloudStorage, this._fetchOwnersUseCase);

  final BaseLocalStorage _localStorage;
  final SharedPreferences _cloudStorage;
  final FetchOwnersUseCase _fetchOwnersUseCase;

  late final List<UserEntity> users;
  late bool isAuthenticated = false;
  final _userSessionKey = 'userId';

  @override
  Future<void> init() async {
    await serviceLocator<LoadUsersUseCase>().call();
    await _fetchOwnersUseCase.call();

    users = serviceLocator<UsersRemoteDataSource>().users;
  }

  @override
  Future<void> logOut() async {
    await clearUserSession();
    _localStorage.clearUser();
    await Future.delayed(const Duration(milliseconds: 200));

    _localStorage.initUser();
    isAuthenticated = false;
  }

  @override
  Future<AuthResult> login({required String email, required String password}) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 1500));

    if (!users.any((element) => element.email == email)) {
      return AuthResult(
        success: false,
        message: serviceLocator<AppLocalisationsCubit>().getLocalisationByKey(
          L10nKeys.authErrorUserNotFoundMessage,
        ),
      );
    }

    if (!users.any((element) => element.password == password && element.email == email)) {
      return AuthResult(
        success: false,
        message: serviceLocator<AppLocalisationsCubit>().getLocalisationByKey(
          L10nKeys.authErrorIncorrectPassword,
        ),
      );
    }

    final user = users.firstWhere((element) => element.email == email);

    await saveUserSession(user.userId);

    _localStorage.clearUser();
    _localStorage.update(UserExtensions.fromEntity(user));

    isAuthenticated = true;
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

    if (users.any((element) => element.email == email)) {
      return AuthResult(
        success: false,
        message: serviceLocator<AppLocalisationsCubit>().getLocalisationByKey(
          L10nKeys.authErrorUserAlreadyExists,
        ),
      );
    }

    final newUserId = serviceLocator<GetMaxUserIdUseCase>().call() + 1;
    final user = UserEntity.initial(
      userId: '$newUserId',
      email: email,
      password: password,
      firstName: firstName,
      lastName: lastName,
    );

    users.add(user);
    await serviceLocator<SaveUsersUseCase>().call(users);
    await saveUserSession(newUserId.toString());

    _localStorage.clearUser();
    _localStorage.update(UserExtensions.fromEntity(user));

    isAuthenticated = true;
    return AuthResult(success: true);
  }

  @override
  Future<void> deleteAccount(String email) async {
    await logOut();

    users.removeWhere((element) => element.email == email);
    await serviceLocator<SaveUsersUseCase>().call(users);
  }

  @override
  Future<void> updateUser(String email, UserEntity data) async {
    if (!isAuthenticated) return;

    users.removeWhere((element) => element.email == email);
    users.add(data);

    await serviceLocator<SaveUsersUseCase>().call(users);
  }

  @override
  Future<SessionEntity?> getUserSession() async {
    final userId = _cloudStorage.getString(_userSessionKey);

    if (userId != null) {
      final sessionId = _generateSessionId();

      return SessionEntity(userId: userId, sessionId: sessionId);
    }
    return null;
  }

  @override
  Future<void> saveUserSession(String userId) async {
    await _cloudStorage.setString(_userSessionKey, userId);
  }

  @override
  Future<void> clearUserSession() async {
    await _cloudStorage.remove(_userSessionKey);
  }

  String _generateSessionId([int length = 32]) {
    final random = Random.secure();
    final values = List<int>.generate(length, (i) => random.nextInt(256));
    return base64Url.encode(values);
  }
}
