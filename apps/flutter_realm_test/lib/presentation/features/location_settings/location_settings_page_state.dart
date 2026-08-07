import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:test_flutter_project/domain/entities/region_entity.dart';
import 'package:test_flutter_project/domain/models/region_ui_model.dart';

part 'location_settings_page_state.freezed.dart';

@freezed
abstract class LocationSettingsPageState with _$LocationSettingsPageState {
  const factory LocationSettingsPageState({
    @Default([]) List<RegionUiModel> availableRegions,
    RegionEntity? currentRegion,
  }) = _LocationSettingsPageState;
}
