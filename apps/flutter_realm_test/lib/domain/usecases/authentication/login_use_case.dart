import 'package:test_flutter_project/domain/models/auth_result.dart';
import 'package:test_flutter_project/domain/models/login_model.dart';

import '../../repositories/auth_repository.dart';
import '../usecase.dart';

class LoginUseCase extends UseCaseWithParams<LoginModel, Future<AuthResult>> {
  final AuthRepository _authRepository;

  LoginUseCase(this._authRepository);

  @override
  Future<AuthResult> call(LoginModel model) {
    return _authRepository.login(email: model.email, password: model.password);
  }
}
