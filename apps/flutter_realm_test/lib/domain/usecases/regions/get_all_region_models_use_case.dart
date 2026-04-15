import 'package:test_flutter_project/domain/models/region_ui_model.dart';
import 'package:test_flutter_project/domain/repositories/region_model_repository.dart';
import 'package:test_flutter_project/domain/usecases/usecase.dart';

class GetAllRegionModelsUseCase extends UseCaseNoParams<List<RegionUiModel>> {
  final RegionModelRepository _regionModelRepository;

  GetAllRegionModelsUseCase(this._regionModelRepository);

  @override
  List<RegionUiModel> call() {
    return _regionModelRepository.getAvailableCountries();
  }
}
