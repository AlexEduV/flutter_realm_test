import 'package:test_flutter_project/domain/data_sources/remote/owners_remote_data_source.dart';
import 'package:test_flutter_project/domain/entities/owner_entity.dart';
import 'package:test_flutter_project/domain/repositories/owner_repository.dart';

class OwnerRepositoryImpl implements OwnerRepository {
  OwnerRepositoryImpl(this._ownersRemoteDataSource);

  final OwnersRemoteDataSource _ownersRemoteDataSource;

  @override
  Future<List<OwnerEntity>> fetchOwners() {
    return _ownersRemoteDataSource.fetchOwners();
  }

  @override
  OwnerEntity getOwnerById(String id) {
    return _ownersRemoteDataSource.getOwnerById(id);
  }
}
