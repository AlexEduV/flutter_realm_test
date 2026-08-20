import '../../entities/owner_entity.dart';

abstract interface class OwnersRemoteDataSource {
  Future<List<OwnerEntity>> fetchOwners();

  OwnerEntity getOwnerById(String id);
}
