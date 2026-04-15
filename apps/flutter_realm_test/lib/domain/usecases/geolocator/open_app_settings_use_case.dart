import 'package:test_flutter_project/domain/repositories/geolocator_repository.dart';

import '../usecase.dart';

class OpenAppSettingsUseCase implements UseCaseNoParams<Future<bool>> {
  OpenAppSettingsUseCase(this._geolocatorRepository);

  final GeolocatorRepository _geolocatorRepository;

  @override
  Future<bool> call() {
    return _geolocatorRepository.openAppSettings();
  }
}
