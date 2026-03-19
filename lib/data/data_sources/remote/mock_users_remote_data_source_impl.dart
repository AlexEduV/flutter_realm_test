import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_futter_project/domain/data_sources/remote/users_remote_data_source.dart';
import 'package:test_futter_project/domain/entities/user_entity.dart';
import 'package:test_futter_project/mocks/mock_users.dart';

class MockUsersRemoteDataSourceImpl implements UsersRemoteDataSource {
  late List<UserEntity> initialUsers = MockUsers.initialUsers;

  @override
  int getMaxUserId() {
    final maxId = initialUsers.isNotEmpty
        ? initialUsers.map((e) => int.parse(e.userId)).reduce((a, b) => a > b ? a : b)
        : 0;

    return maxId;
  }

  @override
  UserEntity? getUserByEmail(String email) {
    return initialUsers.where((element) => element.email == email).firstOrNull;
  }

  @override
  UserEntity? getUserById(String id) {
    final user = initialUsers.firstWhereOrNull((element) => element.userId == id);

    return user;
  }

  @override
  Future<List<UserEntity>> loadMockUsers() async {
    final prefs = await SharedPreferences.getInstance();
    final usersJson = prefs.getString('mock_users');
    if (usersJson != null) {
      final decoded = jsonDecode(usersJson);

      if (decoded is! List) {
        await saveMockUsers(initialUsers);
        return initialUsers;
      }

      final users = decoded
          .map<UserEntity>((value) => UserEntity.fromJson(value as Map<String, dynamic>))
          .toList();

      initialUsers = users;
      return users;
    }

    await saveMockUsers(initialUsers);
    return initialUsers;
  }

  @override
  Future<void> saveMockUsers(List<UserEntity> users) async {
    final prefs = await SharedPreferences.getInstance();
    final usersJsonList = users.map((u) => u.toJson()).toList();
    await prefs.setString('mock_users', jsonEncode(usersJsonList));
  }
}
