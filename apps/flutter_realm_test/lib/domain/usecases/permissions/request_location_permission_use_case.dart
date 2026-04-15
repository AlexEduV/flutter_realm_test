import 'package:test_flutter_project/domain/repositories/permission_repository.dart';
import 'package:test_flutter_project/domain/usecases/usecase.dart';

class RequestLocationPermissionUseCase implements UseCaseNoParams<Future<bool>> {
  RequestLocationPermissionUseCase(this._permissionRepository);

  final PermissionRepository _permissionRepository;

  @override
  Future<bool> call() {
    return _permissionRepository.requestLocationPermission();
  }
}
