import '../../data/models/scheme.dart';

class UserEntity {
  final String userId;
  final String firstName;
  final String lastName;
  final String email;
  final bool isLocationPermissionGranted;
  final String region;
  final List<String> favoriteIds;
  final List<String> createdIds;
  final Map<DateTime, String>? lastSeenCar;
  final String password;
  final String? avatarImageSrc;

  const UserEntity({
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.isLocationPermissionGranted,
    required this.favoriteIds,
    required this.createdIds,
    required this.email,
    required this.lastSeenCar,
    required this.password,
    required this.region,
    required this.avatarImageSrc,
  });

  factory UserEntity.fromSchema(User user) {
    return UserEntity(
      userId: user.userId,
      firstName: user.firstName,
      lastName: user.lastName,
      isLocationPermissionGranted: user.isLocationPermissionGranted,
      favoriteIds: user.favoriteIds,
      createdIds: user.createdIds,
      email: user.email,
      lastSeenCar: user.lastSeenCar != null && user.lastSeenCar!.carId != null
          ? {user.lastSeenCar!.date: user.lastSeenCar!.carId!}
          : null,
      password: user.password,
      region: user.region,
      avatarImageSrc: user.avatarImage,
    );
  }

  UserEntity copyWith({
    String? userId,
    String? firstName,
    String? lastName,
    bool? isLocationPermissionGranted,
    List<String>? favoriteIds,
    List<String>? createdIds,
    String? email,
    String? password,
    Map<DateTime, String>? lastSeenCar,
    String? region,
    String? avatarImageSrc,
  }) {
    return UserEntity(
      userId: userId ?? this.userId,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      isLocationPermissionGranted: isLocationPermissionGranted ?? this.isLocationPermissionGranted,
      favoriteIds: favoriteIds ?? this.favoriteIds,
      createdIds: createdIds ?? this.createdIds,
      email: email ?? this.email,
      lastSeenCar: lastSeenCar ?? this.lastSeenCar,
      password: password ?? this.password,
      region: region ?? this.region,
      avatarImageSrc: avatarImageSrc ?? this.avatarImageSrc,
    );
  }
}
