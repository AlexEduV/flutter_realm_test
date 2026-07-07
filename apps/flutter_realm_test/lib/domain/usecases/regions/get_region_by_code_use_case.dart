import 'package:test_flutter_project/domain/entities/region_entity.dart';
import 'package:test_flutter_project/domain/repositories/region_repository.dart';
import 'package:test_flutter_project/domain/usecases/usecase.dart';

class GetRegionByCodeUseCase extends UseCaseWithParams<String, RegionEntity?> {
  GetRegionByCodeUseCase(this._regionRepository);

  final RegionRepository _regionRepository;

  @override
  RegionEntity? call(String code) {
    return _regionRepository.getRegionByCode(code);
  }
}
