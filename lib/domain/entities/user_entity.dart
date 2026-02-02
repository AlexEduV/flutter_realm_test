import '../../data/models/scheme.dart';

class UserEntity {
  final String userId;
  final String firstName;
  final String lastName;
  final bool isLocationPermissionGranted;

  const UserEntity({
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.isLocationPermissionGranted,
  });

  factory UserEntity.fromSchema(User user) {
    return UserEntity(
      userId: user.userId,
      firstName: user.firstName,
      lastName: user.lastName,
      isLocationPermissionGranted: user.isLocationPermissionGranted,
    );
  }
}
