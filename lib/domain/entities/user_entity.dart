import '../../data/models/scheme.dart';

class UserEntity {
  final String userId;
  final String firstName;
  final String lastName;
  final String email;
  final bool isLocationPermissionGranted;
  final List<String> favoriteIds;
  final Map<DateTime, String>? lastSeenCar;

  const UserEntity({
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.isLocationPermissionGranted,
    required this.favoriteIds,
    required this.email,
    required this.lastSeenCar,
  });

  factory UserEntity.fromSchema(User user) {
    return UserEntity(
      userId: user.userId,
      firstName: user.firstName,
      lastName: user.lastName,
      isLocationPermissionGranted: user.isLocationPermissionGranted,
      favoriteIds: user.favoriteIds,
      email: user.email,
      lastSeenCar: user.lastSeenCar != null && user.lastSeenCar!.carId != null
          ? {user.lastSeenCar!.date: user.lastSeenCar!.carId!}
          : null,
    );
  }

  UserEntity copyWith({
    String? userId,
    String? firstName,
    String? lastName,
    bool? isLocationPermissionGranted,
    List<String>? favoriteIds,
    String? email,
    Map<DateTime, String>? lastSeenCar,
  }) {
    return UserEntity(
      userId: userId ?? this.userId,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      isLocationPermissionGranted: isLocationPermissionGranted ?? this.isLocationPermissionGranted,
      favoriteIds: favoriteIds ?? this.favoriteIds,
      email: email ?? this.email,
      lastSeenCar: lastSeenCar ?? this.lastSeenCar,
    );
  }
}
