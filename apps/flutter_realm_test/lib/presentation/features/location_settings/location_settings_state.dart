import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:test_flutter_project/domain/models/region_ui_model.dart';

part 'location_settings_state.freezed.dart';

@freezed
abstract class LocationSettingsState with _$LocationSettingsState {
  const factory LocationSettingsState({@Default([]) List<RegionUiModel> availableRegions}) =
      _LocationSettingsState;
}
