import 'package:test_flutter_project/common/enums/auth_error_code.dart';
import 'package:test_flutter_project/domain/data_sources/local/app_local_storage.dart';
import 'package:test_flutter_project/domain/data_sources/remote/app_remote_storage.dart';
import 'package:test_flutter_project/domain/data_sources/remote/messages_remote_data_source.dart';
import 'package:test_flutter_project/domain/models/auth_result.dart';
import 'package:test_flutter_project/domain/repositories/auth_repository.dart';
import 'package:test_flutter_project/domain/repositories/owner_repository.dart';

import '../../common/extensions/user_scheme_extension.dart';
import '../../domain/data_sources/remote/users_remote_data_source.dart';
import '../../domain/entities/user_entity.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(
    this._localStorage,
    this._remoteStorage,
    this._usersRemoteDataSource,
    this._messagesRemoteDataSource,
    this._ownerRepository,
  );

  final AppLocalStorage _localStorage;
  final AppRemoteStorage _remoteStorage;
  final OwnerRepository _ownerRepository;
  final UsersRemoteDataSource _usersRemoteDataSource;
  final MessagesRemoteDataSource _messagesRemoteDataSource;

  late final List<UserEntity> users;
  bool _isAuthenticated = false;
  final _userSessionKey = 'userId';

  Future<void> init() async {
    await _usersRemoteDataSource.loadSeedUsers();
    await _ownerRepository.fetchOwners();

    users = List.from(_usersRemoteDataSource.users);
  }

  @override
  Future<void> logOut() async {
    await _clearUserSession();
    _localStorage.clearUser();

    await _simulateNetworkDelay();

    _localStorage.initUser();
    _isAuthenticated = false;
  }

  @override
  Future<AuthResult> login({required String email, required String password}) async {
    await _simulateNetworkDelay();

    if (!users.any((element) => element.email == email)) {
      return const AuthFailure(AuthErrorCode.userNotFound);
    }

    if (!users.any((element) => element.password == password && element.email == email)) {
      return const AuthFailure(AuthErrorCode.incorrectPassword);
    }

    final user = users.firstWhere((element) => element.email == email);

    await _saveUserSession(user.userId);

    _messagesRemoteDataSource.initSampleData(user.userId);

    _localStorage.clearUser();
    _localStorage.update(UserExtensions.fromEntity(user));

    _isAuthenticated = true;
    return const AuthSuccess();
  }

  @override
  Future<AuthResult> register({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  }) async {
    await _simulateNetworkDelay();

    if (users.any((element) => element.email == email)) {
      return const AuthFailure(AuthErrorCode.userAlreadyExists);
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

    await _usersRemoteDataSource.saveSeedUsers(users);
    await _saveUserSession(newUserId.toString());

    _localStorage.clearUser();
    _localStorage.update(UserExtensions.fromEntity(user));

    _isAuthenticated = true;
    return const AuthSuccess();
  }

  @override
  Future<void> deleteAccount(String email) async {
    await logOut();

    users.removeWhere((element) => element.email == email);
    _usersRemoteDataSource.users = List.from(users);
    await _usersRemoteDataSource.saveSeedUsers(users);
  }

  @override
  Future<void> updateUser(String userId, UserEntity data) async {
    if (!_isAuthenticated) return;

    users.removeWhere((element) => element.userId == userId);
    users.add(data);

    await _usersRemoteDataSource.saveSeedUsers(users);
  }

  @override
  bool isUserLoggedIn() {
    return _remoteStorage.getString(_userSessionKey) != null;
  }

  Future<void> _saveUserSession(String userId) async {
    await _remoteStorage.setString(_userSessionKey, userId);
  }

  Future<void> _clearUserSession() async {
    await _remoteStorage.remove(_userSessionKey);
  }

  Future<void> _simulateNetworkDelay({int duration = 1500}) async {
    await Future.delayed(Duration(milliseconds: duration));
  }
}
