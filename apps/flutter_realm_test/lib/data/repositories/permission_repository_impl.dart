import 'package:permission_handler/permission_handler.dart';
import 'package:test_flutter_project/domain/services/permission_service.dart';
import 'package:test_flutter_project/domain/repositories/permission_repository.dart';

class PermissionRepositoryImpl implements PermissionRepository {
  PermissionRepositoryImpl(this.permissionService);

  final PermissionService permissionService;

  @override
  Future<bool> requestLocationPermission() async {
    final status = await permissionService.requestLocation();
    return status.isGranted;
  }

  @override
  Future<PermissionStatus> checkLocationPermissionState() async {
    final status = await permissionService.checkLocationStatus();
    return status;
  }
}
