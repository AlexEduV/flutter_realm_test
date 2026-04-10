import '../models/region_ui_model.dart';

abstract class RegionModelRepository {
  Future<void> init();
  List<RegionUiModel> getAvailableCountries();
}
