import '../models/region_ui_model.dart';

abstract interface class RegionModelRepository {
  Future<void> init();
  List<RegionUiModel> getAvailableCountries();
}
