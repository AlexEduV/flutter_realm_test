import '../entities/user_entity.dart';

abstract class UserRepository {
  int getMaxUserId();

  UserEntity? getUserByEmail(String email);

  UserEntity? getUserById(String id);

  Future<List<UserEntity>> loadSeedUsers();

  Future<void> saveSeedUsers(List<UserEntity> users);
}
