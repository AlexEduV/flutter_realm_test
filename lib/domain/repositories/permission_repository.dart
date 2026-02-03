abstract class PermissionRepository {
  Future<bool> requestLocationPermission();
  Future<bool> checkLocationPermissionState();
}
