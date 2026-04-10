import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:test_futter_project/common/enums/car_type.dart';
import 'package:test_futter_project/common/enums/drawer_type.dart';
import 'package:test_futter_project/domain/models/field_params_model.dart';

import '../../../domain/entities/car_entity.dart';

part 'search_page_state.freezed.dart';

@freezed
abstract class SearchPageState with _$SearchPageState {
  const factory SearchPageState({
    @Default([]) List<CarEntity> results,
    @Default([]) List<CarEntity> allResults,
    @Default(CarType.car) CarType currentSelectedType,
    @Default(false) bool isLoading,
    @Default({}) Map<String, List<String>> allModels,
    @Default({}) Map<String, List<String>> selectedModels,
    String? selectedMinYear,
    String? selectedMaxYear,
    @Default([]) List<String> allColors,
    @Default([]) List<String> selectedColors,
    String? minYearError,
    String? maxYearError,
    @Default([]) List<String> selectedBodyTypes,
    String? selectedMinPrice,
    String? selectedMaxPrice,
    String? minPriceError,
    String? maxPriceError,
    FieldParamsModel? minYearFieldParamsModel,
    FieldParamsModel? maxYearFieldParamsModel,
    FieldParamsModel? minPriceFieldParamsModel,
    FieldParamsModel? maxPriceFieldParamsModel,
    @Default([]) List<String> selectedFuelTypes,
    @Default([]) List<String> selectedTransmissionTypes,
    @Default(SearchDrawerType.empty) SearchDrawerType drawerOpened,
  }) = _SearchPageState;
}
