import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_flutter_project/domain/data_sources/local/base_local_storage.dart';
import 'package:test_flutter_project/domain/data_sources/remote/messages_remote_data_source.dart';
import 'package:test_flutter_project/domain/models/auth_result.dart';
import 'package:test_flutter_project/domain/repositories/auth_repository.dart';
import 'package:test_flutter_project/domain/repositories/owner_repository.dart';
import 'package:test_flutter_project/l10n/l10n_keys.dart';
import 'package:test_flutter_project/presentation/features/l10n/app_localisations_cubit.dart';

import '../../common/extensions/user_scheme_extension.dart';
import '../../core/di/injection_container.dart';
import '../../domain/data_sources/remote/users_remote_data_source.dart';
import '../../domain/entities/user_entity.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(
    this._localStorage,
    this._cloudStorage,
    this._usersRemoteDataSource,
    this._messagesRemoteDataSource,
    this._ownerRepository,
  );

  final BaseLocalStorage _localStorage;
  final SharedPreferences _cloudStorage;
  final OwnerRepository _ownerRepository;
  final UsersRemoteDataSource _usersRemoteDataSource;
  final MessagesRemoteDataSource _messagesRemoteDataSource;

  late final List<UserEntity> users;
  late bool isAuthenticated = false;
  final _userSessionKey = 'userId';

  Future<void> init() async {
    await _usersRemoteDataSource.loadMockUsers();
    await _ownerRepository.fetchOwners();

    users = List.from(_usersRemoteDataSource.users);
  }

  @override
  Future<void> logOut() async {
    await _clearUserSession();
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

    await _saveUserSession(user.userId);

    _messagesRemoteDataSource.initSampleData(user.userId);

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

    final newUserId = _usersRemoteDataSource.getMaxUserId() + 1;
    final user = UserEntity.initial(
      userId: '$newUserId',
      email: email,
      password: password,
      firstName: firstName,
      lastName: lastName,
    );

    users.add(user);
    _usersRemoteDataSource.users = List.from(users);

    await _usersRemoteDataSource.saveMockUsers(users);
    await _saveUserSession(newUserId.toString());

    _localStorage.clearUser();
    _localStorage.update(UserExtensions.fromEntity(user));

    isAuthenticated = true;
    return AuthResult(success: true);
  }

  @override
  Future<void> deleteAccount(String email) async {
    await logOut();

    users.removeWhere((element) => element.email == email);
    _usersRemoteDataSource.users = List.from(users);
    await _usersRemoteDataSource.saveMockUsers(users);
  }

  @override
  Future<void> updateUser(String userId, UserEntity data) async {
    if (!isAuthenticated) return;

    users.removeWhere((element) => element.userId == userId);
    users.add(data);

    await _usersRemoteDataSource.saveMockUsers(users);
  }

  @override
  Future<bool> isUserLoggedIn() async {
    return _cloudStorage.getString(_userSessionKey) != null;
  }

  Future<void> _saveUserSession(String userId) async {
    await _cloudStorage.setString(_userSessionKey, userId);
  }

  Future<void> _clearUserSession() async {
    await _cloudStorage.remove(_userSessionKey);
  }
}
