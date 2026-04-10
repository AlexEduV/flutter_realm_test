import 'package:test_futter_project/domain/repositories/region_model_repository.dart';
import 'package:test_futter_project/domain/usecases/usecase.dart';

class InitRegionModelsUseCase extends UseCaseNoParams<Future<void>> {
  final RegionModelRepository _regionModelRepository;

  InitRegionModelsUseCase(this._regionModelRepository);

  @override
  Future<void> call() {
    return _regionModelRepository.init();
  }
}
