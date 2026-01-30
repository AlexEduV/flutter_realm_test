import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:test_futter_project/common/enums/car_type.dart';
import 'package:test_futter_project/common/enums/drawer_type.dart';

import '../../../domain/entities/car_entity.dart';

part 'search_page_state.freezed.dart';

@freezed
abstract class SearchPageState with _$SearchPageState {
  const factory SearchPageState({
    @Default([]) List<CarEntity> results,
    @Default(CarType.car) CarType currentSelectedType,
    @Default(false) bool isLoading,
    @Default([]) List<String> allModels,
    @Default([]) List<String> selectedModels,
    @Default(SearchDrawerType.empty) SearchDrawerType drawerOpened,
  }) = _SearchPageState;
}
