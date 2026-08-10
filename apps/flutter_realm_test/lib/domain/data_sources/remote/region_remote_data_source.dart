import '../../entities/region_entity.dart';

abstract class RegionRemoteDataSource {
  Future<void> init();

  Future<void> loadRegions();
  List<RegionEntity> getAllRegions();
}
