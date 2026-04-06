import '../entities/user_entity.dart';

abstract class UserRepository {
  int getMaxUserId();

  UserEntity? getUserByEmail(String email);

  UserEntity? getUserById(String id);

  Future<List<UserEntity>> loadMockUsers();

  Future<void> saveMockUsers(List<UserEntity> users);
}
