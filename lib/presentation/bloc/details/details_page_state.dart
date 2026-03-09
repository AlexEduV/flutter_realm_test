import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:test_futter_project/domain/entities/car_entity.dart';

part 'details_page_state.freezed.dart';

@freezed
abstract class DetailsPageState with _$DetailsPageState {
  const factory DetailsPageState({
    @Default(false) bool isLoading,
    CarEntity? car,
    @Default(true) bool isVehicleSpecsExpanded,
  }) = _DetailsPageState;
}
