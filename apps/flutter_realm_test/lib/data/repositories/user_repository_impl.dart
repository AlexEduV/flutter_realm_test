import 'package:test_flutter_project/domain/data_sources/remote/users_remote_data_source.dart';
import 'package:test_flutter_project/domain/entities/user_entity.dart';
import 'package:test_flutter_project/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UsersRemoteDataSource _usersRemoteDataSource;

  UserRepositoryImpl(this._usersRemoteDataSource);

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
  Future<List<UserEntity>> loadMockUsers() {
    return _usersRemoteDataSource.loadMockUsers();
  }

  @override
  Future<void> saveMockUsers(List<UserEntity> users) {
    return _usersRemoteDataSource.saveMockUsers(users);
  }
}
