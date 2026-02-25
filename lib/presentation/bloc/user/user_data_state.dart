import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entities/car_entity.dart';

part 'user_data_state.freezed.dart';

@freezed
abstract class UserDataState with _$UserDataState {
  const factory UserDataState({
    @Default(false) bool isLoading,
    @Default(false) bool isLocationPermissionGranted,
    @Default([]) List<String> favoriteIds,
    @Default(false) bool isUserAuthenticated,
    @Default('') String firstName,
    @Default('') String lastName,
    @Default('') String email,
    @Default('') String password,
    @Default(null) Map<DateTime, CarEntity>? lastSeenCar,
  }) = _UserDataState;
}
