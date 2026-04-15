import 'package:permission_handler/permission_handler.dart';
import 'package:test_flutter_project/domain/repositories/permission_repository.dart';
import 'package:test_flutter_project/domain/usecases/usecase.dart';

class CheckLocationPermissionStatusUseCase implements UseCaseNoParams<Future<PermissionStatus>> {
  CheckLocationPermissionStatusUseCase(this._permissionRepository);

  final PermissionRepository _permissionRepository;

  @override
  Future<PermissionStatus> call() {
    return _permissionRepository.checkLocationPermissionState();
  }
}
