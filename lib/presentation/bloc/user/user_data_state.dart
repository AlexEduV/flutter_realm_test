import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_data_state.freezed.dart';

@freezed
abstract class UserDataState with _$UserDataState {
  const factory UserDataState({
    @Default(false) bool isLoading,
    @Default(false) bool isLocationPermissionGranted,
    @Default([]) List<String> favoriteIds,
    @Default([]) List<String> createdIds,
    @Default([]) List<String> viewedIds,
    @Default(false) bool isUserAuthenticated,
    @Default('') String firstName,
    @Default('') String lastName,
    @Default('') String email,
    @Default('') String password,
    @Default('') String region,
    Map<DateTime, String>? lastSeenCar,
    String? avatarImageSrc,
  }) = _UserDataState;
}
