import '../../entities/user_entity.dart';

abstract class UsersRemoteDataSource {
  Future<void> saveMockUsers(List<UserEntity> users);

  Future<List<UserEntity>> loadMockUsers();

  UserEntity? getUserByEmail(String email);

  int getMaxUserId();

  UserEntity? getUserById(String id);
}
