import 'package:permission_handler/permission_handler.dart';

abstract interface class PermissionService {
  Future<PermissionStatus> requestLocation();
  Future<PermissionStatus> checkLocationStatus();
}
