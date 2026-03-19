import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test_futter_project/data/repositories/user_repository_impl.dart';
import 'package:test_futter_project/domain/data_sources/remote/users_remote_data_source.dart';
import 'package:test_futter_project/domain/entities/user_entity.dart';

import 'user_repository_impl_test.mocks.dart';

@GenerateMocks([UsersRemoteDataSource])
void main() {
  late MockUsersRemoteDataSource mockRemoteDataSource;
  late UserRepositoryImpl repository;

  setUp(() {
    mockRemoteDataSource = MockUsersRemoteDataSource();
    repository = UserRepositoryImpl(mockRemoteDataSource);
  });

  test('getMaxUserId should delegate to remote data source', () {
    // Arrange
    const tMaxUserId = 99;
    when(mockRemoteDataSource.getMaxUserId()).thenReturn(tMaxUserId);

    // Act
    final result = repository.getMaxUserId();

    // Assert
    expect(result, tMaxUserId);
    verify(mockRemoteDataSource.getMaxUserId()).called(1);
    verifyNoMoreInteractions(mockRemoteDataSource);
  });

  test('getUserByEmail should delegate to remote data source', () {
    // Arrange
    const tEmail = 'test@example.com';
    final tUser = UserEntity.initial(
      userId: '1',
      firstName: 'Test',
      lastName: 'User',
      email: 'mock@mock.com',
      password: 'test',
    );
    when(mockRemoteDataSource.getUserByEmail(tEmail)).thenReturn(tUser);

    // Act
    final result = repository.getUserByEmail(tEmail);

    // Assert
    expect(result, tUser);
    verify(mockRemoteDataSource.getUserByEmail(tEmail)).called(1);
    verifyNoMoreInteractions(mockRemoteDataSource);
  });

  test('getUserById should delegate to remote data source', () {
    // Arrange
    const tId = '123';
    final tUser = UserEntity.initial(
      userId: tId,
      firstName: 'Test',
      lastName: 'User',
      email: 'mock@mock.com',
      password: 'test',
    );
    when(mockRemoteDataSource.getUserById(tId)).thenReturn(tUser);

    // Act
    final result = repository.getUserById(tId);

    // Assert
    expect(result, tUser);
    verify(mockRemoteDataSource.getUserById(tId)).called(1);
    verifyNoMoreInteractions(mockRemoteDataSource);
  });

  test('loadMockUsers should delegate to remote data source', () async {
    // Arrange
    final tUsers = [
      UserEntity.initial(
        userId: '1',
        firstName: 'User',
        lastName: 'One',
        email: 'mock1@mock.com',
        password: 'test',
      ),
      UserEntity.initial(
        userId: '2',
        firstName: 'User',
        lastName: 'Two',
        email: 'mock2@mock.com',
        password: 'test',
      ),
    ];
    when(mockRemoteDataSource.loadMockUsers()).thenAnswer((_) async => tUsers);

    // Act
    final result = await repository.loadMockUsers();

    // Assert
    expect(result, tUsers);
    verify(mockRemoteDataSource.loadMockUsers()).called(1);
    verifyNoMoreInteractions(mockRemoteDataSource);
  });

  test('saveMockUsers should delegate to remote data source', () async {
    // Arrange
    final tUsers = [
      UserEntity.initial(
        userId: '1',
        firstName: 'User',
        lastName: 'One',
        email: 'mock1@mock.com',
        password: 'test',
      ),
      UserEntity.initial(
        userId: '2',
        firstName: 'User',
        lastName: 'Two',
        email: 'mock2@mock.com',
        password: 'test',
      ),
    ];
    when(mockRemoteDataSource.saveMockUsers(tUsers)).thenAnswer((_) async => {});

    // Act
    await repository.saveMockUsers(tUsers);

    // Assert
    verify(mockRemoteDataSource.saveMockUsers(tUsers)).called(1);
    verifyNoMoreInteractions(mockRemoteDataSource);
  });
}
