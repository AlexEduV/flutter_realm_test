import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:test_futter_project/domain/models/auth_result.dart';
import 'package:test_futter_project/domain/models/register_model.dart';
import 'package:test_futter_project/domain/usecases/authentication/register_use_case.dart';

import '../../../data/data_sources/remote/mock_auth_service_test.mocks.dart';

void main() {
  late MockAuthRepository mockAuthRepository;
  late RegisterUseCase registerUseCase;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    registerUseCase = RegisterUseCase(mockAuthRepository);
  });

  test('calls register on the repository with correct params and returns result', () async {
    // Arrange
    final registerModel = RegisterModel('test@mail.com', 'password123', 'Test', 'User');
    final expectedResult = AuthResult(success: true, message: 'Registered');
    when(
      mockAuthRepository.register(
        email: registerModel.email,
        password: registerModel.password,
        firstName: registerModel.firstName,
        lastName: registerModel.lastName,
      ),
    ).thenAnswer((_) async => expectedResult);

    // Act
    final result = await registerUseCase(registerModel);

    // Assert
    expect(result, expectedResult);
    verify(
      mockAuthRepository.register(
        email: registerModel.email,
        password: registerModel.password,
        firstName: registerModel.firstName,
        lastName: registerModel.lastName,
      ),
    ).called(1);
  });
}
