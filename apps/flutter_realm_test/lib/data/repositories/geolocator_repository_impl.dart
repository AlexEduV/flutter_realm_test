import 'package:test_flutter_project/domain/data_sources/local/geolocator_local_data_source.dart';
import 'package:test_flutter_project/domain/repositories/geolocator_repository.dart';

class GeolocatorRepositoryImpl implements GeolocatorRepository {
  GeolocatorRepositoryImpl(this._geolocatorService);

  final GeolocatorLocalDataSource _geolocatorService;

  @override
  Future<bool> checkLocationServiceStatus() {
    return _geolocatorService.checkLocationServiceStatus();
  }

  @override
  Future<bool> openAppSettings() {
    return _geolocatorService.openLocationSettings();
  }
}
