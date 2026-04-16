import 'dart:ui';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:test_flutter_project/domain/entities/car_entity.dart';

part 'details_page_state.freezed.dart';

@freezed
abstract class DetailsPageState with _$DetailsPageState {
  const factory DetailsPageState({
    @Default(false) bool isLoading,
    @Default(true) bool isVehicleSpecsExpanded,
    CarEntity? car,
    Color? carColor,
  }) = _DetailsPageState;
}
