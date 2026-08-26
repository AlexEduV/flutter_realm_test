import 'package:test_flutter_project/domain/repositories/geolocator_repository.dart';
import 'package:test_flutter_project/domain/services/logging_service.dart';

import '../usecase.dart';

class OpenAppSettingsUseCase implements UseCaseNoParams<Future<bool>> {
  OpenAppSettingsUseCase(this._loggingService, this._geolocatorRepository);

  final LoggingService _loggingService;
  final GeolocatorRepository _geolocatorRepository;

  @override
  Future<bool> call() async {
    final canAppSettingsBeOpened = await _geolocatorRepository.openAppSettings();
    if (!canAppSettingsBeOpened) {
      _loggingService.error('Could not open system location settings');
    }

    return canAppSettingsBeOpened;
  }
}
