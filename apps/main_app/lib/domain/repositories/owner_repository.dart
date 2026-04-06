import '../entities/owner_entity.dart';

abstract class OwnerRepository {
  Future<List<OwnerEntity>> fetchOwners();

  OwnerEntity getOwnerById(String id);
}
