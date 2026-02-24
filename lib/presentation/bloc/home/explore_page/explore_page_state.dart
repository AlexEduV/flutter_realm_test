import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:test_futter_project/domain/entities/car_entity.dart';

part 'explore_page_state.freezed.dart';

@freezed
abstract class ExplorePageState with _$ExplorePageState {
  const factory ExplorePageState({
    @Default([]) List<CarEntity> cars,
    @Default(false) bool isLoading,
    @Default(null) CarEntity? lastSeenCar,
  }) = _ExplorePageState;
}
