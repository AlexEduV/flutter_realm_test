import 'package:geolocator/geolocator.dart';
import 'package:test_flutter_project/domain/services/geolocator_service.dart';

class GeolocatorServiceImpl implements GeolocatorService {
  @override
  Future<bool> checkLocationServiceStatus() {
    return Geolocator.isLocationServiceEnabled();
  }

  @override
  Future<bool> openLocationSettings() {
    return Geolocator.openLocationSettings();
  }
}
