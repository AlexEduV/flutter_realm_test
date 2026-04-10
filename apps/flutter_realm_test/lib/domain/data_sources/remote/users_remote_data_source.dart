import '../../entities/user_entity.dart';

abstract class UsersRemoteDataSource {
  late List<UserEntity> users;

  Future<void> saveMockUsers(List<UserEntity> users);

  Future<List<UserEntity>> loadMockUsers();

  UserEntity? getUserByEmail(String email);

  int getMaxUserId();

  UserEntity? getUserById(String id);
}
