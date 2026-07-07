import 'package:test_flutter_project/domain/models/region_ui_model.dart';
import 'package:test_flutter_project/domain/repositories/region_model_repository.dart';
import 'package:test_flutter_project/domain/usecases/usecase.dart';

class GetAllRegionModelsUseCase extends UseCaseNoParams<List<RegionUiModel>> {
  GetAllRegionModelsUseCase(this._regionModelRepository);

  final RegionModelRepository _regionModelRepository;

  @override
  List<RegionUiModel> call() {
    return _regionModelRepository.getAvailableCountries();
  }
}
