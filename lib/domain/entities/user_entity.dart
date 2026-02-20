import '../../data/models/scheme.dart';

class UserEntity {
  final String userId;
  final String firstName;
  final String lastName;
  final String email;
  final bool isLocationPermissionGranted;
  final List<String> favoriteIds;

  const UserEntity({
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.isLocationPermissionGranted,
    required this.favoriteIds,
    required this.email,
  });

  factory UserEntity.fromSchema(User user) {
    return UserEntity(
      userId: user.userId,
      firstName: user.firstName,
      lastName: user.lastName,
      isLocationPermissionGranted: user.isLocationPermissionGranted,
      favoriteIds: user.favoriteIds,
      email: user.email,
    );
  }

  UserEntity copyWith({
    String? userId,
    String? firstName,
    String? lastName,
    bool? isLocationPermissionGranted,
    List<String>? favoriteIds,
    String? email,
  }) {
    return UserEntity(
      userId: userId ?? this.userId,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      isLocationPermissionGranted: isLocationPermissionGranted ?? this.isLocationPermissionGranted,
      favoriteIds: favoriteIds ?? this.favoriteIds,
      email: email ?? this.email,
    );
  }
}
