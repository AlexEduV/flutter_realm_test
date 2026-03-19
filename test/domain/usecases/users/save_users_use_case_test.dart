import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:test_futter_project/domain/entities/user_entity.dart';
import 'package:test_futter_project/domain/usecases/users/save_users_use_case.dart';

import 'get_max_user_id_use_case_test.mocks.dart';

void main() {
  late MockUserRepository mockUserRepository;
  late SaveUsersUseCase useCase;

  setUp(() {
    mockUserRepository = MockUserRepository();
    useCase = SaveUsersUseCase(mockUserRepository);
  });

  test('should call saveMockUsers on repository with correct params', () async {
    // Arrange
    final tUsers = [
      UserEntity.initial(
        userId: '1',
        firstName: 'User',
        lastName: 'One',
        email: 'mock',
        password: 'test',
      ),
      UserEntity.initial(
        userId: '2',
        firstName: 'User',
        lastName: 'Two',
        email: 'mock2',
        password: 'test2',
      ),
    ];
    when(mockUserRepository.saveMockUsers(tUsers)).thenAnswer((_) async {});

    // Act
    await useCase(tUsers);

    // Assert
    verify(mockUserRepository.saveMockUsers(tUsers)).called(1);
    verifyNoMoreInteractions(mockUserRepository);
  });

  test('should complete without error when repository succeeds', () {
    // Arrange
    final tUsers = <UserEntity>[];
    when(mockUserRepository.saveMockUsers(tUsers)).thenAnswer((_) async {});

    // Act & Assert
    expect(useCase(tUsers), completes);
    verify(mockUserRepository.saveMockUsers(tUsers)).called(1);
    verifyNoMoreInteractions(mockUserRepository);
  });
}
