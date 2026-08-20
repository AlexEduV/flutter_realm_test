abstract interface class GeolocatorService {
  Future<bool> checkLocationServiceStatus();
  Future<bool> openLocationSettings();
}
