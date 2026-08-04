import 'package:test_flutter_project/domain/data_sources/remote/owners_remote_data_source.dart';
import 'package:test_flutter_project/domain/data_sources/remote/users_remote_data_source.dart';
import 'package:test_flutter_project/domain/entities/owner_entity.dart';
import 'package:test_flutter_project/domain/entities/user_entity.dart';
import 'package:test_flutter_project/domain/repositories/owner_repository.dart';
import 'package:test_flutter_project/domain/usecases/users/save_users_use_case.dart';

class OwnerRepositoryImpl implements OwnerRepository {
  OwnerRepositoryImpl(
    this._ownersRemoteDataSource,
    this._usersRemoteDataSource,
    this._saveUsersUseCase,
  );

  final OwnersRemoteDataSource _ownersRemoteDataSource;
  final UsersRemoteDataSource _usersRemoteDataSource;
  final SaveUsersUseCase _saveUsersUseCase;

  @override
  Future<List<OwnerEntity>> fetchOwners() async {
    final owners = await _ownersRemoteDataSource.fetchOwners();
    await _syncUsersFromOwners(owners);
    return owners;
  }

  @override
  OwnerEntity getOwnerById(String id) {
    return _ownersRemoteDataSource.getOwnerById(id);
  }

  Future<void> _syncUsersFromOwners(List<OwnerEntity> owners) async {
    for (final owner in owners) {
      final exists = _usersRemoteDataSource.users.any((u) => u.userId == owner.id);
      if (!exists) {
        _usersRemoteDataSource.users.add(UserEntity.fromOwner(owner));
      }
    }
    await _saveUsersUseCase.call(_usersRemoteDataSource.users);
  }
}
