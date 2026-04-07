import '../domain/entities/user_entity.dart';

class MockUsers {
  static List<UserEntity> initialUsers = [
    UserEntity.initial(
      userId: '16',
      firstName: 'John',
      lastName: 'Doe',
      email: 'mock@gmail.com',
      password: 'qwertyUI10!',
    ),
    UserEntity.initial(
      userId: '17',
      firstName: 'Jane',
      lastName: 'Doe',
      email: 'mock1@gmail.com',
      password: 'qwertyUI10!',
    ),
  ];
}
