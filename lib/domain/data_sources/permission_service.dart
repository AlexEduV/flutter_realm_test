import 'package:permission_handler/permission_handler.dart';

abstract class PermissionService {
  Future<PermissionStatus> requestLocation();
  Future<PermissionStatus> checkLocationStatus();
}
