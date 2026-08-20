abstract interface class GeolocatorRepository {
  Future<bool> checkLocationServiceStatus();
  Future<bool> openAppSettings();
}
