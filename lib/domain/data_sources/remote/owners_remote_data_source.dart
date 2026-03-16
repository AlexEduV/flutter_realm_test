import '../../entities/owner_entity.dart';

abstract class OwnersRemoteDataSource {
  Future<List<OwnerEntity>> fetchOwners();

  OwnerEntity getOwnerById(String id);
}
