import '../../models/region_ui_model.dart';

abstract class RegionRemoteDataSource {
  Future<void> init();
  List<RegionUiModel> getAvailableCountries();
}
