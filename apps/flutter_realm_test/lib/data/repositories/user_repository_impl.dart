import 'package:test_flutter_project/domain/data_sources/remote/users_remote_data_source.dart';
import 'package:test_flutter_project/domain/entities/user_entity.dart';
import 'package:test_flutter_project/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  UserRepositoryImpl(this._usersRemoteDataSource);

  final UsersRemoteDataSource _usersRemoteDataSource;

  @override
  int getMaxUserId() {
    return _usersRemoteDataSource.getMaxUserId();
  }

  @override
  UserEntity? getUserByEmail(String email) {
    return _usersRemoteDataSource.getUserByEmail(email);
  }

  @override
  UserEntity? getUserById(String id) {
    return _usersRemoteDataSource.getUserById(id);
  }

  @override
  Future<List<UserEntity>> loadSeedUsers() {
    return _usersRemoteDataSource.loadSeedUsers();
  }

  @override
  Future<void> saveSeedUsers(List<UserEntity> users) {
    return _usersRemoteDataSource.saveSeedUsers(users);
  }
}
