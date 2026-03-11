import 'package:test_futter_project/domain/data_sources/geolocator_service.dart';
import 'package:test_futter_project/domain/repositories/geolocator_repository.dart';

class GeolocatorRepositoryImpl implements GeolocatorRepository {
  final GeolocatorService _geolocatorService;

  GeolocatorRepositoryImpl(this._geolocatorService);

  @override
  Future<bool> checkLocationServiceStatus() {
    return _geolocatorService.checkLocationServiceStatus();
  }

  @override
  Future<bool> openAppSettings() {
    return _geolocatorService.openLocationSettings();
  }
}
