import 'package:test_flutter_project/domain/repositories/auth_repository.dart';
import 'package:test_flutter_project/domain/usecases/usecase.dart';

class LogoutUseCase extends UseCaseNoParams<Future<void>> {
  LogoutUseCase(this._authRepository);

  final AuthRepository _authRepository;

  @override
  Future<void> call() {
    return _authRepository.logOut();
  }
}
