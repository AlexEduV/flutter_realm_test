import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_futter_project/domain/data_sources/remote/users_remote_data_source.dart';
import 'package:test_futter_project/domain/entities/user_entity.dart';
import 'package:test_futter_project/mocks/mock_users.dart';

class MockUsersRemoteDataSourceImpl implements UsersRemoteDataSource {
  @override
  int getMaxUserId() {
    final maxId = users.isNotEmpty
        ? users.map((e) => int.parse(e.userId)).reduce((a, b) => a > b ? a : b)
        : 0;

    return maxId;
  }

  @override
  UserEntity? getUserByEmail(String email) {
    return users.where((element) => element.email == email).firstOrNull;
  }

  @override
  UserEntity? getUserById(String id) {
    final user = users.firstWhereOrNull((element) => element.userId == id);

    return user;
  }

  @override
  Future<List<UserEntity>> loadMockUsers() async {
    final prefs = await SharedPreferences.getInstance();
    final usersJson = prefs.getString('mock_users');
    if (usersJson != null) {
      final decoded = jsonDecode(usersJson);

      if (decoded is! List) {
        await saveMockUsers(this.users);
        return this.users;
      }

      final users = decoded
          .map<UserEntity>((value) => UserEntity.fromJson(value as Map<String, dynamic>))
          .toList();

      this.users = users;
      return users;
    }

    await saveMockUsers(users);
    return users;
  }

  @override
  Future<void> saveMockUsers(List<UserEntity> users) async {
    final prefs = await SharedPreferences.getInstance();
    final usersJsonList = users.map((u) => u.toJson()).toList();
    await prefs.setString('mock_users', jsonEncode(usersJsonList));
  }

  @override
  List<UserEntity> users = MockUsers.initialUsers;
}
