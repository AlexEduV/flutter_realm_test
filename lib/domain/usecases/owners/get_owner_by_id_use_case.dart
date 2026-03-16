import 'package:test_futter_project/domain/entities/owner_entity.dart';
import 'package:test_futter_project/domain/repositories/owner_repository.dart';
import 'package:test_futter_project/domain/usecases/usecase.dart';

class GetOwnerByIdUseCase implements UseCaseWithParams<String, OwnerEntity> {
  GetOwnerByIdUseCase(this._ownerRepository);

  final OwnerRepository _ownerRepository;

  @override
  OwnerEntity call(String params) {
    return _ownerRepository.getOwnerById(params);
  }
}
