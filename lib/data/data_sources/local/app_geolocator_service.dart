import 'package:geolocator/geolocator.dart';
import 'package:test_futter_project/domain/data_sources/geolocator_service.dart';

class AppGeolocatorService implements GeolocatorService {
  @override
  Future<bool> checkLocationServiceStatus() {
    return Geolocator.isLocationServiceEnabled();
  }

  @override
  Future<bool> openLocationSettings() {
    return Geolocator.openLocationSettings();
  }
}
