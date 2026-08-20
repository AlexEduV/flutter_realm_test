import '../entities/owner_entity.dart';

abstract interface class OwnerRepository {
  Future<List<OwnerEntity>> fetchOwners();

  OwnerEntity getOwnerById(String id);
}
