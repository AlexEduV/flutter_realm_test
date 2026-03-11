import 'package:permission_handler/permission_handler.dart';
import 'package:test_futter_project/domain/data_sources/permission_service.dart';

class PermissionHandlerService implements PermissionService {
  @override
  Future<PermissionStatus> requestLocation() {
    return Permission.location.request();
  }

  @override
  Future<PermissionStatus> checkLocationStatus() {
    return Permission.location.status;
  }
}
