import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:test_flutter_project/domain/models/auth_result.dart';
import 'package:test_flutter_project/domain/models/login_model.dart';
import 'package:test_flutter_project/domain/usecases/authentication/login_use_case.dart';

import '../../../presentation/features/user/user_data_cubit_test.mocks.dart';

void main() {
  late MockAuthRepository mockAuthRepository;
  late LoginUseCase loginUseCase;

  setUp(() {
    provideDummy<AuthResult>(const AuthSuccess());
    mockAuthRepository = MockAuthRepository();
    loginUseCase = LoginUseCase(mockAuthRepository);
  });

  test('calls login on the repository with correct params and returns result', () async {
    // Arrange
    final loginModel = LoginModel('test@mail.com', 'password123');
    const expectedResult = AuthSuccess();
    when(
      mockAuthRepository.login(email: loginModel.email, password: loginModel.password),
    ).thenAnswer((_) async => expectedResult);

    // Act
    final result = await loginUseCase(loginModel);

    // Assert
    expect(result, expectedResult);
    verify(
      mockAuthRepository.login(email: loginModel.email, password: loginModel.password),
    ).called(1);
  });
}
