import 'package:test_futter_project/domain/repositories/permission_repository.dart';
import 'package:test_futter_project/domain/usecases/usecase.dart';

class RequestLocationPermissionUseCase implements UseCase<Future<bool>, void> {
  RequestLocationPermissionUseCase(this._permissionRepository);

  final PermissionRepository _permissionRepository;

  @override
  Future<bool> call(void params) {
    return _permissionRepository.requestLocationPermission();
  }
}
