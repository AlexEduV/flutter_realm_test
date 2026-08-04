import 'package:test_flutter_project/domain/data_sources/remote/owners_remote_data_source.dart';
import 'package:test_flutter_project/domain/data_sources/remote/users_remote_data_source.dart';
import 'package:test_flutter_project/domain/entities/owner_entity.dart';
import 'package:test_flutter_project/domain/entities/user_entity.dart';
import 'package:test_flutter_project/domain/repositories/owner_repository.dart';

class OwnerRepositoryImpl implements OwnerRepository {
  OwnerRepositoryImpl(this._ownersRemoteDataSource, this._usersRemoteDataSource);

  final OwnersRemoteDataSource _ownersRemoteDataSource;
  final UsersRemoteDataSource _usersRemoteDataSource;

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
      final isExisting = _usersRemoteDataSource.users.any((u) => u.userId == owner.id);
      if (!isExisting) {
        _usersRemoteDataSource.users.add(UserEntity.fromOwner(owner));
      }
    }
    await _usersRemoteDataSource.saveMockUsers(_usersRemoteDataSource.users);
  }
}
