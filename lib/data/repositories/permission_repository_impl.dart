// ignore: depend_on_referenced_packages
import 'package:permission_handler/permission_handler.dart';
import 'package:test_futter_project/domain/repositories/permission_repository.dart';

class PermissionRepositoryImpl implements PermissionRepository {
  @override
  Future<bool> requestLocationPermission() async {
    final status = await Permission.location.request();
    return status.isGranted;
  }

  @override
  Future<bool> checkLocationPermissionState() async {
    final status = await Permission.location.status;
    return status.isGranted;
  }
}
