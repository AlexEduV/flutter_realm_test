import 'package:test_futter_project/domain/repositories/region_model_repository.dart';
import 'package:test_futter_project/domain/usecases/usecase.dart';

class InitRegionModelsUseCase extends UseCaseNoParams<Future<void>> {
  final RegionModelRepository regionModelRepository;

  InitRegionModelsUseCase(this.regionModelRepository);

  @override
  Future<void> call() {
    return regionModelRepository.init();
  }
}
