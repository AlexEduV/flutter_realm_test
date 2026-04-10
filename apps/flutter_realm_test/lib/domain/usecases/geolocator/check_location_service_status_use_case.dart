import 'package:test_futter_project/domain/repositories/geolocator_repository.dart';

import '../usecase.dart';

class CheckLocationServiceStatusUseCase implements UseCaseNoParams<Future<bool>> {
  CheckLocationServiceStatusUseCase(this._geolocatorRepository);

  final GeolocatorRepository _geolocatorRepository;

  @override
  Future<bool> call() {
    return _geolocatorRepository.checkLocationServiceStatus();
  }
}
