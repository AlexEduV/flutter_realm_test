import 'package:permission_handler/permission_handler.dart';
import 'package:test_flutter_project/domain/data_sources/local/permission_local_data_source.dart';

class PermissionLocalDataSourceImpl implements PermissionLocalDataSource {
  @override
  Future<PermissionStatus> requestLocation() {
    return Permission.location.request();
  }

  @override
  Future<PermissionStatus> checkLocationStatus() {
    return Permission.location.status;
  }
}
