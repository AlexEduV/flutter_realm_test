import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:test_flutter_project/domain/usecases/authentication/logout_use_case.dart';

import '../../../presentation/bloc/user/user_data_cubit_test.mocks.dart';

void main() {
  late MockAuthRepository mockAuthRepository;
  late LogoutUseCase logoutUseCase;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    logoutUseCase = LogoutUseCase(mockAuthRepository);
  });

  test('calls logOut on the repository', () async {
    // Arrange
    when(mockAuthRepository.logOut()).thenAnswer((_) async {});

    // Act
    await logoutUseCase();

    // Assert
    verify(mockAuthRepository.logOut()).called(1);
  });
}
