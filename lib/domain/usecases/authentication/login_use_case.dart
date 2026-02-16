import 'package:test_futter_project/domain/models/auth_result.dart';
import 'package:test_futter_project/domain/models/login_model.dart';

import '../../repositories/auth_repository.dart';
import '../usecase.dart';

class LoginUseCase extends UseCaseWithParams<LoginModel, Future<AuthResult>> {
  final AuthRepository authRepository;

  LoginUseCase(this.authRepository);

  @override
  Future<AuthResult> call(LoginModel model) {
    return authRepository.login(email: model.email, password: model.password);
  }
}
