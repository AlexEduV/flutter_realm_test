import 'package:test_futter_project/domain/entities/region_entity.dart';
import 'package:test_futter_project/domain/repositories/region_repository.dart';
import 'package:test_futter_project/domain/usecases/usecase.dart';

class GetAllRegionsUseCase extends UseCaseNoParams<List<RegionEntity>> {
  final RegionRepository _regionRepository;

  GetAllRegionsUseCase(this._regionRepository);

  @override
  List<RegionEntity> call() {
    return _regionRepository.getAllRegions();
  }
}
