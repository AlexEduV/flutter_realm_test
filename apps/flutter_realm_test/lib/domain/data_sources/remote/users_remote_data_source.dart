import '../../entities/user_entity.dart';

abstract class UsersRemoteDataSource {
  late List<UserEntity> users;

  Future<void> saveSeedUsers(List<UserEntity> users);

  Future<List<UserEntity>> loadSeedUsers();

  UserEntity? getUserByEmail(String email);

  int getMaxUserId();

  UserEntity? getUserById(String id);
}
