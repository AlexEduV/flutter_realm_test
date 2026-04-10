import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:test_futter_project/domain/entities/user_entity.dart';
import 'package:test_futter_project/domain/usecases/users/get_user_by_email_use_case.dart';

import 'get_max_user_id_use_case_test.mocks.dart';

void main() {
  late MockUserRepository mockUserRepository;
  late GetUserByEmailUseCase useCase;

  setUp(() {
    mockUserRepository = MockUserRepository();
    useCase = GetUserByEmailUseCase(mockUserRepository);
  });

  test('should return UserEntity for a valid email', () {
    // Arrange
    const tEmail = 'test@example.com';
    final tUser = UserEntity.initial(
      userId: '1',
      firstName: 'Test',
      lastName: 'User',
      email: 'mock@mock.com',
      password: 'test',
    );
    when(mockUserRepository.getUserByEmail(tEmail)).thenReturn(tUser);

    // Act
    final result = useCase(tEmail);

    // Assert
    expect(result, tUser);
    verify(mockUserRepository.getUserByEmail(tEmail)).called(1);
    verifyNoMoreInteractions(mockUserRepository);
  });

  test('should return null when user is not found', () {
    // Arrange
    const tEmail = 'notfound@example.com';
    when(mockUserRepository.getUserByEmail(tEmail)).thenReturn(null);

    // Act
    final result = useCase(tEmail);

    // Assert
    expect(result, isNull);
    verify(mockUserRepository.getUserByEmail(tEmail)).called(1);
    verifyNoMoreInteractions(mockUserRepository);
  });
}
