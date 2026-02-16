import 'package:test_futter_project/domain/repositories/auth_repository.dart';
import 'package:test_futter_project/domain/usecases/usecase.dart';

class LogoutUseCase extends UseCaseNoParams<void> {
  final AuthRepository authRepository;

  LogoutUseCase(this.authRepository);

  @override
  void call() async {
    return authRepository.logOut();
  }
}
