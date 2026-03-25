import 'package:test_futter_project/domain/models/region_ui_model.dart';
import 'package:test_futter_project/domain/repositories/region_model_repository.dart';
import 'package:test_futter_project/domain/usecases/usecase.dart';

class GetAllRegionModelsUseCase extends UseCaseNoParams<List<RegionUiModel>> {
  final RegionModelRepository regionModelRepository;

  GetAllRegionModelsUseCase(this.regionModelRepository);

  @override
  List<RegionUiModel> call() {
    return regionModelRepository.getAvailableCountries();
  }
}
