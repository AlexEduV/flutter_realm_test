import '../../entities/region_entity.dart';

abstract interface class RegionRemoteDataSource {
  Future<void> init();

  Future<void> loadRegions();
  List<RegionEntity> getAllRegions();
}
