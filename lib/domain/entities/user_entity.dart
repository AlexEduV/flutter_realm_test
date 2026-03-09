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
  final List<String> viewedIds;
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
    required this.viewedIds,
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
      favoriteIds: user.favoriteIds.toList(),
      createdIds: user.createdIds.toList(),
      viewedIds: user.viewedIds.toList(),
      email: user.email,
      lastSeenCar: user.lastSeenCar != null && user.lastSeenCar!.carId != null
          ? {user.lastSeenCar!.date: user.lastSeenCar!.carId!}
          : null,
      password: user.password,
      region: user.region,
      avatarImageSrc: user.avatarImage,
    );
  }

  factory UserEntity.initial({
    required String userId,
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  }) {
    return UserEntity(
      userId: userId,
      firstName: firstName,
      lastName: lastName,
      email: email,
      password: password,
      region: 'uk',
      isLocationPermissionGranted: false,
      favoriteIds: [],
      createdIds: [],
      viewedIds: [],
      lastSeenCar: null,
      avatarImageSrc: null,
    );
  }

  UserEntity copyWith({
    String? userId,
    String? firstName,
    String? lastName,
    bool? isLocationPermissionGranted,
    List<String>? favoriteIds,
    List<String>? createdIds,
    List<String>? viewedIds,
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
      viewedIds: viewedIds ?? this.viewedIds,
      email: email ?? this.email,
      lastSeenCar: lastSeenCar ?? this.lastSeenCar,
      password: password ?? this.password,
      region: region ?? this.region,
      avatarImageSrc: avatarImageSrc ?? this.avatarImageSrc,
    );
  }

  Map<String, dynamic> toJson() => {
    'userId': userId,
    'email': email,
    'password': password,
    'firstName': firstName,
    'lastName': lastName,
    'region': region,
    'avatarImageSrc': avatarImageSrc,
    'favoriteIds': favoriteIds,
    'viewedIds': viewedIds,
    'createdIds': createdIds,
    'lastSeenCar': lastSeenCar?.map((key, value) => MapEntry(key.toIso8601String(), value)),
    'isLocationPermissionGranted': isLocationPermissionGranted,
  };

  factory UserEntity.fromJson(Map<String, dynamic> json) {
    return UserEntity(
      userId: json['userId'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      region: (json['region'] ?? '') as String,
      avatarImageSrc: json['avatarImageSrc'] as String?,
      lastSeenCar: (json['lastSeenCar'] as Map<String, dynamic>?)?.map(
        (key, value) => MapEntry(DateTime.parse(key), value as String),
      ),
      viewedIds: (json['viewedIds'] as List<dynamic>).map((e) => e as String).toList(),
      createdIds: (json['createdIds'] as List<dynamic>).map((e) => e as String).toList(),
      favoriteIds: (json['favoriteIds'] as List<dynamic>).map((e) => e as String).toList(),
      isLocationPermissionGranted: json['isLocationPermissionGranted'] as bool,
    );
  }
}
