import 'package:permission_handler/permission_handler.dart';

abstract interface class PermissionRepository {
  Future<bool> requestLocationPermission();
  Future<PermissionStatus> checkLocationPermissionState();
}
