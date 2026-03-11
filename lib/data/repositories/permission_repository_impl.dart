import 'package:permission_handler/permission_handler.dart';
import 'package:test_futter_project/domain/data_sources/permission_service.dart';
import 'package:test_futter_project/domain/repositories/permission_repository.dart';

class PermissionRepositoryImpl implements PermissionRepository {
  final PermissionService permissionService;

  PermissionRepositoryImpl(this.permissionService);

  @override
  Future<bool> requestLocationPermission() async {
    final status = await permissionService.requestLocation();
    return status.isGranted;
  }

  @override
  Future<bool> checkLocationPermissionState() async {
    final status = await permissionService.checkLocationStatus();
    return status.isGranted;
  }
}
