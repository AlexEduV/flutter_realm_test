import 'package:test_flutter_project/domain/services/geolocator_service.dart';
import 'package:test_flutter_project/domain/repositories/geolocator_repository.dart';

class GeolocatorRepositoryImpl implements GeolocatorRepository {
  GeolocatorRepositoryImpl(this._geolocatorService);

  final GeolocatorService _geolocatorService;

  @override
  Future<bool> checkLocationServiceStatus() {
    return _geolocatorService.checkLocationServiceStatus();
  }

  @override
  Future<bool> openAppSettings() {
    return _geolocatorService.openLocationSettings();
  }
}
