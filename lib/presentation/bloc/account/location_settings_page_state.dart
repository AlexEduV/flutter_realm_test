import 'package:freezed_annotation/freezed_annotation.dart';

part 'location_settings_page_state.freezed.dart';

@freezed
abstract class LocationSettingsPageState with _$LocationSettingsPageState {
  const factory LocationSettingsPageState({@Default(false) bool isLocationItemAnimating}) =
      _LocationSettingsPageState;
}
