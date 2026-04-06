import '../../entities/region_entity.dart';
import '../../models/region_ui_model.dart';

abstract class RegionRemoteDataSource {
  Future<void> init();

  Future<void> loadRegions();
  List<RegionEntity> getAllRegions();

  List<RegionUiModel> getAvailableCountries();
}
