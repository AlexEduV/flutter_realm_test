import 'package:test_flutter_project/domain/models/auth_result.dart';
import 'package:test_flutter_project/domain/models/register_model.dart';

import '../../repositories/auth_repository.dart';
import '../usecase.dart';

class RegisterUseCase extends UseCaseWithParams<RegisterModel, Future<AuthResult>> {
  RegisterUseCase(this._authRepository);

  final AuthRepository _authRepository;

  @override
  Future<AuthResult> call(RegisterModel model) {
    return _authRepository.register(
      email: model.email,
      password: model.password,
      firstName: model.firstName,
      lastName: model.lastName,
    );
  }
}
