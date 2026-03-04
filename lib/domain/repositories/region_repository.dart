import '../entities/region_entity.dart';

abstract class RegionRepository {
  Future<void> loadRegions();

  RegionEntity? getRegionByCode(String code);

  List<RegionEntity> getAllRegions();
}
