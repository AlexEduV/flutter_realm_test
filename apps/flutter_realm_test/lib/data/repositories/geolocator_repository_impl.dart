import 'package:test_futter_project/domain/data_sources/local/geolocator_local_data_source.dart';
import 'package:test_futter_project/domain/repositories/geolocator_repository.dart';

class GeolocatorRepositoryImpl implements GeolocatorRepository {
  final GeolocatorLocalDataSource _geolocatorService;

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
