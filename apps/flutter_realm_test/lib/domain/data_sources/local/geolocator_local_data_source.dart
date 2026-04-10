abstract class GeolocatorLocalDataSource {
  Future<bool> checkLocationServiceStatus();
  Future<bool> openLocationSettings();
}
