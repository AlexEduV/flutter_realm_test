import 'package:permission_handler/permission_handler.dart';
import 'package:test_flutter_project/domain/services/permission_service.dart';

class PermissionServiceImpl implements PermissionService {
  @override
  Future<PermissionStatus> requestLocation() {
    return Permission.location.request();
  }

  @override
  Future<PermissionStatus> checkLocationStatus() {
    return Permission.location.status;
  }
}
