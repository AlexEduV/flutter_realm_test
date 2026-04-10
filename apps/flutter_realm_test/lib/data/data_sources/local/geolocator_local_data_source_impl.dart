import 'package:geolocator/geolocator.dart';
import 'package:test_futter_project/domain/data_sources/local/geolocator_local_data_source.dart';

class GeolocatorLocalDataSourceImpl implements GeolocatorLocalDataSource {
  @override
  Future<bool> checkLocationServiceStatus() {
    return Geolocator.isLocationServiceEnabled();
  }

  @override
  Future<bool> openLocationSettings() {
    return Geolocator.openLocationSettings();
  }
}
