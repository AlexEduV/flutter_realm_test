import 'package:test_futter_project/domain/entities/owner_entity.dart';

import '../../repositories/owner_repository.dart';
import '../usecase.dart';

class FetchOwnersUseCase extends UseCaseNoParams<Future<List<OwnerEntity>>> {
  final OwnerRepository _ownersRepository;

  FetchOwnersUseCase(this._ownersRepository);

  @override
  Future<List<OwnerEntity>> call() {
    return _ownersRepository.fetchOwners();
  }
}
