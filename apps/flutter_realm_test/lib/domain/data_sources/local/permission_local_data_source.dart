import 'package:permission_handler/permission_handler.dart';

abstract class PermissionLocalDataSource {
  Future<PermissionStatus> requestLocation();
  Future<PermissionStatus> checkLocationStatus();
}
