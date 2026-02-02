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

  UserEntity copyWith({
    String? userId,
    String? firstName,
    String? lastName,
    bool? isLocationPermissionGranted,
  }) {
    return UserEntity(
      userId: userId ?? this.userId,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      isLocationPermissionGranted: isLocationPermissionGranted ?? this.isLocationPermissionGranted,
    );
  }
}
