import 'package:test_futter_project/domain/repositories/auth_repository.dart';
import 'package:test_futter_project/domain/usecases/usecase.dart';

class DeleteAccountUseCase extends UseCaseWithParams<String, Future<void>> {
  final AuthRepository authRepository;

  DeleteAccountUseCase(this.authRepository);

  @override
  Future<void> call(String email) {
    return authRepository.deleteAccount(email);
  }
}
