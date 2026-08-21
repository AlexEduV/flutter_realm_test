import 'package:test_flutter_project/common/enums/auth_error_code.dart';
import 'package:test_flutter_project/domain/data_sources/local/app_local_storage.dart';
import 'package:test_flutter_project/domain/data_sources/remote/app_remote_storage.dart';
import 'package:test_flutter_project/domain/data_sources/remote/messages_remote_data_source.dart';
import 'package:test_flutter_project/domain/models/auth_result.dart';
import 'package:test_flutter_project/domain/repositories/auth_repository.dart';
import 'package:test_flutter_project/domain/repositories/owner_repository.dart';

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
  final UsersRemoteDataSource _usersRemoteDataSource;
  final MessagesRemoteDataSource _messagesRemoteDataSource;
  final OwnerRepository _ownerRepository;

  late List<UserEntity> _users;
  bool _isAuthenticated = false;
  static const _userSessionKey = 'userId';

  Future<void> init() async {
    await _usersRemoteDataSource.loadSeedUsers();
    await _ownerRepository.fetchOwners();

    _users = List.from(_usersRemoteDataSource.users);
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

    if (!_users.any((element) => element.email == email)) {
      return const AuthFailure(AuthErrorCode.userNotFound);
    }

    if (!_users.any((element) => element.password == password && element.email == email)) {
      return const AuthFailure(AuthErrorCode.incorrectPassword);
    }

    final user = _users.firstWhere((element) => element.email == email);

    await _saveUserSession(user.userId);

    _messagesRemoteDataSource.initSampleData(user.userId);

    _localStorage.clearUser();
    _localStorage.updateUser(user);

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

    if (_users.any((element) => element.email == email)) {
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

    _users = [..._users, user];
    _usersRemoteDataSource.users = List.from(_users);

    await _usersRemoteDataSource.saveSeedUsers(_users);
    await _saveUserSession(newUserId.toString());

    _localStorage.clearUser();
    _localStorage.updateUser(user);

    _isAuthenticated = true;
    return const AuthSuccess();
  }

  @override
  Future<void> deleteAccount(String email) async {
    await logOut();

    _users = _users.where((element) => element.email != email).toList();
    _usersRemoteDataSource.users = List.from(_users);
    await _usersRemoteDataSource.saveSeedUsers(_users);
  }

  @override
  Future<void> updateUser(String userId, UserEntity updatedUser) async {
    if (!_isAuthenticated) return;

    _users = [..._users.where((e) => e.userId != userId), updatedUser];

    _usersRemoteDataSource.users = List.from(_users);
    await _usersRemoteDataSource.saveSeedUsers(_users);
  }

  @override
  Future<bool> isUserLoggedIn() async {
    return await _remoteStorage.getString(_userSessionKey) != null;
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
