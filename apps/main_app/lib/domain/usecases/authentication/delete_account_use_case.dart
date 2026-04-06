import 'package:test_futter_project/domain/repositories/auth_repository.dart';
import 'package:test_futter_project/domain/usecases/usecase.dart';

class DeleteAccountUseCase extends UseCaseWithParams<String, Future<void>> {
  final AuthRepository _authRepository;

  DeleteAccountUseCase(this._authRepository);

  @override
  Future<void> call(String email) {
    return _authRepository.deleteAccount(email);
  }
}
