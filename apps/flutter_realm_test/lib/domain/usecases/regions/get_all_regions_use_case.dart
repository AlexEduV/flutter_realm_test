import 'package:test_flutter_project/domain/entities/region_entity.dart';
import 'package:test_flutter_project/domain/repositories/region_repository.dart';
import 'package:test_flutter_project/domain/usecases/usecase.dart';

class GetAllRegionsUseCase extends UseCaseNoParams<List<RegionEntity>> {
  GetAllRegionsUseCase(this._regionRepository);

  final RegionRepository _regionRepository;

  @override
  List<RegionEntity> call() {
    return _regionRepository.getAllRegions();
  }
}
