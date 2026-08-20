import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:test_flutter_project/domain/data_sources/remote/app_remote_storage.dart';
import 'package:test_flutter_project/domain/data_sources/remote/users_remote_data_source.dart';
import 'package:test_flutter_project/domain/entities/user_entity.dart';

import '../../../fixtures/seed_users.dart';

class SeedUsersRemoteDataSourceImpl implements UsersRemoteDataSource {
  SeedUsersRemoteDataSourceImpl(this._remoteStorage);

  static const _seedUsersLocalStorageKey = 'seed_users';
  final AppRemoteStorage _remoteStorage;

  @override
  int getMaxUserId() {
    final maxId = users.isNotEmpty
        ? users.map((e) => int.parse(e.userId)).reduce((a, b) => a > b ? a : b)
        : 0;

    return maxId;
  }

  @override
  UserEntity? getUserByEmail(String email) {
    return users.firstWhereOrNull((element) => element.email == email);
  }

  @override
  UserEntity? getUserById(String id) {
    final user = users.firstWhereOrNull((element) => element.userId == id);

    return user;
  }

  @override
  Future<List<UserEntity>> loadSeedUsers() async {
    final usersJson = await _remoteStorage.getString(_seedUsersLocalStorageKey);
    if (usersJson != null) {
      final decoded = jsonDecode(usersJson);

      if (decoded is! List) {
        await saveSeedUsers(this.users);
        return this.users;
      }

      final users = decoded
          .map<UserEntity>((value) => UserEntity.fromJson(value as Map<String, dynamic>))
          .toList();

      this.users = users;
      return users;
    }

    await saveSeedUsers(users);
    return users;
  }

  @override
  Future<void> saveSeedUsers(List<UserEntity> users) async {
    final usersJsonList = users.map((user) => user.toJson()).toList();
    await _remoteStorage.setString(_seedUsersLocalStorageKey, jsonEncode(usersJsonList));
  }

  @override
  List<UserEntity> users = List.from(SeedUsers.initialUsers);
}
