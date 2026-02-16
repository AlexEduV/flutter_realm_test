import 'package:test_futter_project/domain/models/auth_result.dart';
import 'package:test_futter_project/domain/models/register_model.dart';

import '../../repositories/auth_repository.dart';
import '../usecase.dart';

class RegisterUseCase extends UseCaseWithParams<RegisterModel, Future<AuthResult>> {
  final AuthRepository authRepository;

  RegisterUseCase(this.authRepository);

  @override
  Future<AuthResult> call(RegisterModel model) {
    return authRepository.register(
      email: model.email,
      password: model.password,
      fullName: model.fullName,
    );
  }
}
