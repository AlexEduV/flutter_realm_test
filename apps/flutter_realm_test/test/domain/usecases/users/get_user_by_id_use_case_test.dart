import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:test_flutter_project/domain/entities/user_entity.dart';
import 'package:test_flutter_project/domain/usecases/users/get_user_by_id_use_case.dart';

import 'get_max_user_id_use_case_test.mocks.dart';

void main() {
  late MockUserRepository mockUserRepository;
  late GetUserByIdUseCase useCase;

  setUp(() {
    mockUserRepository = MockUserRepository();
    useCase = GetUserByIdUseCase(mockUserRepository);
  });

  test('should return UserEntity for a valid user id', () {
    // Arrange
    const tUserId = '123';
    final tUser = UserEntity.initial(
      userId: tUserId,
      firstName: 'Test',
      lastName: 'User',
      email: 'test@mock.com',
      password: 'test',
    );
    when(mockUserRepository.getUserById(tUserId)).thenReturn(tUser);

    // Act
    final result = useCase(tUserId);

    // Assert
    expect(result, tUser);
    verify(mockUserRepository.getUserById(tUserId)).called(1);
    verifyNoMoreInteractions(mockUserRepository);
  });

  test('should return null when user is not found', () {
    // Arrange
    const tUserId = 'not_found';
    when(mockUserRepository.getUserById(tUserId)).thenReturn(null);

    // Act
    final result = useCase(tUserId);

    // Assert
    expect(result, isNull);
    verify(mockUserRepository.getUserById(tUserId)).called(1);
    verifyNoMoreInteractions(mockUserRepository);
  });
}
