import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart' show Cubit;
import 'package:test_flutter_project/common/enums/car_type.dart';
import 'package:test_flutter_project/common/enums/drawer_type.dart';
import 'package:test_flutter_project/common/extensions/list_extension.dart';
import 'package:test_flutter_project/common/extensions/string_extension.dart';
import 'package:test_flutter_project/domain/entities/car_entity.dart';
import 'package:test_flutter_project/domain/models/field_params_model.dart';
import 'package:test_flutter_project/domain/usecases/database/get_all_cars_use_case.dart';
import 'package:test_flutter_project/domain/usecases/database/watch_cars_use_case.dart';
import 'package:test_flutter_project/presentation/features/search/search_page_identifiers.dart';
import 'package:test_flutter_project/presentation/features/search/search_page_state.dart';

import '../l10n/app_localisations_cubit.dart';
import '../l10n/l10n_keys.dart';

class SearchPageCubit extends Cubit<SearchPageState> {
  SearchPageCubit(this._getAllCarsUseCase, this._watchCarsUseCase, this._appLocalisationsCubit)
    : super(const SearchPageState());

  StreamSubscription? _carSubscription;

  final GetAllCarsUseCase _getAllCarsUseCase;
  final WatchCarsUseCase _watchCarsUseCase;
  final AppLocalisationsCubit _appLocalisationsCubit;

  void init() {
    emit(
      state.copyWith(
        minYearFieldParamsModel:
            FieldParamsModel.withLabel(
              _appLocalisationsCubit.getLocalisationByKey(L10nKeys.fieldParamsHintMin),
            ).copyWith(
              validationMessage: _appLocalisationsCubit.getLocalisationByKey(
                SearchPageLocaleKeys.filterValidationMessage,
              ),
            ),
        maxYearFieldParamsModel:
            FieldParamsModel.withLabel(
              _appLocalisationsCubit.getLocalisationByKey(L10nKeys.fieldParamsHintMax),
            ).copyWith(
              validationMessage: _appLocalisationsCubit.getLocalisationByKey(
                SearchPageLocaleKeys.filterValidationMessage,
              ),
            ),
        minPriceFieldParamsModel:
            FieldParamsModel.withLabel(
              _appLocalisationsCubit.getLocalisationByKey(L10nKeys.fieldParamsHintMin),
            ).copyWith(
              validationMessage: _appLocalisationsCubit.getLocalisationByKey(
                SearchPageLocaleKeys.filterValidationMessage,
              ),
            ),
        maxPriceFieldParamsModel:
            FieldParamsModel.withLabel(
              _appLocalisationsCubit.getLocalisationByKey(L10nKeys.fieldParamsHintMax),
            ).copyWith(
              validationMessage: _appLocalisationsCubit.getLocalisationByKey(
                SearchPageLocaleKeys.filterValidationMessage,
              ),
            ),
      ),
    );

    loadData();
  }

  void loadData() {
    emit(state.copyWith(isLoading: true));

    final allCars = _getAllCarsUseCase.call();
    final currentType = state.currentSelectedType;

    updateModelListFromEntities(allCars, currentType);
    updateColorListFromEntities(allCars, currentType);

    updateSelectedMinYear(getMinYearFromEntities(allCars, currentType));
    updateSelectedMaxYear(getMaxYearFromEntities(allCars, currentType));

    updateSelectedMinPrice(getMinPriceFromEntities(allCars, currentType));
    updateSelectedMaxPrice(getMaxPriceFromEntities(allCars, currentType));

    emit(state.copyWith(allResults: allCars, isLoading: false));

    _carSubscription?.cancel();
    _carSubscription = _watchCarsUseCase.call().listen((entities) {
      emit(state.copyWith(allResults: entities));
    });
  }

  List<CarEntity> getFilteredResults(List<CarEntity> cars) {
    final minYear = int.tryParse(state.selectedMinYear ?? '');
    final maxYear = int.tryParse(state.selectedMaxYear ?? '');

    final minPrice = int.tryParse(state.selectedMinPrice ?? '');
    final maxPrice = int.tryParse(state.selectedMaxPrice ?? '');

    return cars.where((car) {
      // Year filter
      final carYear = int.tryParse(car.year ?? '') ?? 0;
      if (minYear != null && carYear < minYear) {
        return false;
      }

      if (maxYear != null && carYear > maxYear) {
        return false;
      }

      // Price filter
      final carPrice = car.price ?? 0;
      if (minPrice != null && carPrice < minPrice) {
        return false;
      }

      if (maxPrice != null && carPrice > maxPrice) {
        return false;
      }

      // Type filter
      if (car.type != state.currentSelectedType.name) {
        return false;
      }

      // Model filter
      if (state.selectedModels.isNotEmpty &&
          !(state.selectedModels[car.manufacturer]?.contains(car.model) ?? false)) {
        return false;
      }

      //Color filter
      if (state.selectedColors.isNotEmptyAndNotContains(car.color)) {
        return false;
      }

      // Body type filter
      if (state.selectedBodyTypes.isNotEmptyAndNotContains(car.bodyType)) {
        return false;
      }

      // Fuel type filter
      if (state.selectedFuelTypes.isNotEmptyAndNotContains(car.engine.type)) {
        return false;
      }

      // Transmission type filter
      if (state.selectedTransmissionTypes.isNotEmptyAndNotContains(car.transmissionType)) {
        return false;
      }

      return true;
    }).toList();
  }

  void updateTypeSelection(CarType newType) {
    updateModelListFromEntities(state.allResults, newType);
    updateColorListFromEntities(state.allResults, newType);

    updateSelectedMinYear(getMinYearFromEntities(state.allResults, newType));
    updateSelectedMaxYear(getMaxYearFromEntities(state.allResults, newType));

    updateSelectedMinPrice(getMinPriceFromEntities(state.allResults, newType));
    updateSelectedMaxPrice(getMaxPriceFromEntities(state.allResults, newType));

    emit(state.copyWith(currentSelectedType: newType, selectedModels: {}, selectedBodyTypes: []));
  }

  void updateModelListFromEntities(List<CarEntity> cars, CarType type) {
    final modelsByManufacturerMap = cars
        .where((car) => car.type == type.name)
        .fold(<String, Set<String>>{}, (map, car) {
          map.putIfAbsent(car.manufacturer, () => {}).add(car.model);
          return map;
        })
        .map((key, models) => MapEntry(key, models.toList()));

    emit(state.copyWith(allModels: modelsByManufacturerMap));
  }

  void updateColorListFromEntities(List<CarEntity> cars, CarType type) {
    final allColors = cars
        .where((element) => element.type == type.name)
        .map((element) => element.color?.capitalizeFirst())
        .whereType<String>()
        .toSet()
        .toList();

    emit(state.copyWith(allColors: allColors));
  }

  String getMinYearFromEntities(List<CarEntity> cars, CarType type) {
    final filteredYears = cars
        .where((element) => element.type == type.name)
        .map((element) => int.tryParse(element.year ?? ''))
        .whereType<int>() // filters out nulls from failed parses
        .toList();

    final minYear = filteredYears.isNotEmpty ? filteredYears.reduce((a, b) => a < b ? a : b) : 0;

    return minYear.toString();
  }

  String getMaxYearFromEntities(List<CarEntity> cars, CarType type) {
    final filteredYears = cars
        .where((element) => element.type == type.name)
        .map((element) => int.tryParse(element.year ?? ''))
        .whereType<int>() // filters out nulls from failed parses
        .toList();

    final maxYear = filteredYears.isNotEmpty ? filteredYears.reduce((a, b) => a > b ? a : b) : 2056;

    return maxYear.toString();
  }

  String getMinPriceFromEntities(List<CarEntity> cars, CarType type) {
    final filteredPrices = cars
        .where((element) => element.type == type.name)
        .map((element) => element.price)
        .whereType<int>() // filters out nulls from failed parses
        .toList();

    final minPrice = filteredPrices.isNotEmpty && filteredPrices.length != 1
        ? filteredPrices.reduce((a, b) => a < b ? a : b)
        : 0;

    return minPrice.toString();
  }

  String getMaxPriceFromEntities(List<CarEntity> cars, CarType type) {
    final filteredPrices = cars
        .where((element) => element.type == type.name)
        .map((element) => element.price)
        .whereType<int>() // filters out nulls from failed parses
        .toList();

    final maxPrice = filteredPrices.isNotEmpty && filteredPrices.length != 1
        ? filteredPrices.reduce((a, b) => a > b ? a : b)
        : 200000;

    return maxPrice.toString();
  }

  void updateModelSelection(Map<String, List<String>> newList) {
    emit(state.copyWith(selectedModels: newList));
  }

  void addManufacturerToSelection(String manufacturer) {
    final map = Map<String, List<String>>.from(state.selectedModels);
    map[manufacturer] = state.allModels[manufacturer] ?? [];
    emit(state.copyWith(selectedModels: map));
  }

  void removeManufacturerFromSelection(String manufacturer) {
    final map = Map<String, List<String>>.from(state.selectedModels);
    map.remove(manufacturer);
    emit(state.copyWith(selectedModels: map));
  }

  void addCarModelToSelection(String manufacturer, String model) {
    final map = Map<String, List<String>>.from(state.selectedModels);
    map.putIfAbsent(manufacturer, () => []);
    if (!map[manufacturer]!.contains(model)) {
      map[manufacturer]!.add(model);
    }
    emit(state.copyWith(selectedModels: map));
  }

  void removeCarModelFromSelection(String manufacturer, String model) {
    final map = Map<String, List<String>>.from(state.selectedModels);
    if (map.containsKey(manufacturer)) {
      final models = List<String>.from(map[manufacturer]!);
      models.remove(model);
      if (models.isEmpty) {
        map.remove(manufacturer);
      } else {
        map[manufacturer] = models;
      }
    }
    emit(state.copyWith(selectedModels: map));
  }

  void addCarColorToSelection(String color) {
    emit(state.copyWith(selectedColors: List<String>.from(state.selectedColors)..add(color)));
  }

  void removeCarColorFromSelection(String color) {
    emit(state.copyWith(selectedColors: List<String>.from(state.selectedColors)..remove(color)));
  }

  void addBodyTypeToSelection(String bodyType) {
    emit(
      state.copyWith(selectedBodyTypes: List<String>.from(state.selectedBodyTypes)..add(bodyType)),
    );
  }

  void removeBodyTypeFromSelection(String bodyType) {
    emit(
      state.copyWith(
        selectedBodyTypes: List<String>.from(state.selectedBodyTypes)..remove(bodyType),
      ),
    );
  }

  void addFuelTypeToSelection(String fuelType) {
    emit(
      state.copyWith(selectedFuelTypes: List<String>.from(state.selectedFuelTypes)..add(fuelType)),
    );
  }

  void removeFuelTypeFromSelection(String fuelType) {
    emit(
      state.copyWith(
        selectedFuelTypes: List<String>.from(state.selectedFuelTypes)..remove(fuelType),
      ),
    );
  }

  void addTransmissionTypeToSelection(String transmissionType) {
    emit(
      state.copyWith(
        selectedTransmissionTypes: List<String>.from(state.selectedTransmissionTypes)
          ..add(transmissionType),
      ),
    );
  }

  void removeTransmissionTypeFromSelection(String transmissionType) {
    emit(
      state.copyWith(
        selectedTransmissionTypes: List<String>.from(state.selectedTransmissionTypes)
          ..remove(transmissionType),
      ),
    );
  }

  void updateSelectedMinYear(String newValue) {
    emit(state.copyWith(selectedMinYear: newValue));
    validateYears(state.selectedMinYear, state.selectedMaxYear);
  }

  void updateSelectedMaxYear(String newValue) {
    emit(state.copyWith(selectedMaxYear: newValue));
    validateYears(state.selectedMinYear, state.selectedMaxYear);
  }

  void updateSelectedMinPrice(String newValue) {
    emit(state.copyWith(selectedMinPrice: newValue));
    validatePrices(state.selectedMinPrice, state.selectedMaxPrice);
  }

  void updateSelectedMaxPrice(String newValue) {
    emit(state.copyWith(selectedMaxPrice: newValue));
    validatePrices(state.selectedMinPrice, state.selectedMaxPrice);
  }

  void openDrawer(SearchDrawerType type) {
    emit(state.copyWith(drawerOpened: type));
  }

  bool validateYears(String? minYearString, String? maxYearString) {
    final minYear = int.tryParse(minYearString ?? '');
    final maxYear = int.tryParse(maxYearString ?? '');

    if (minYear != null && maxYear != null && minYear > maxYear) {
      emit(
        state.copyWith(
          minYearError: state.minYearFieldParamsModel?.validationMessage,
          maxYearError: state.maxYearFieldParamsModel?.validationMessage,
        ),
      );

      return false;
    }

    emit(state.copyWith(minYearError: null, maxYearError: null));
    return true;
  }

  bool validatePrices(String? minPriceString, String? maxPriceString) {
    final minPrice = int.tryParse(minPriceString ?? '');
    final maxPrice = int.tryParse(maxPriceString ?? '');

    if (minPrice != null && maxPrice != null && minPrice > maxPrice) {
      emit(
        state.copyWith(
          minPriceError: state.minPriceFieldParamsModel?.validationMessage,
          maxPriceError: state.maxPriceFieldParamsModel?.validationMessage,
        ),
      );

      return false;
    }

    emit(state.copyWith(minPriceError: null, maxPriceError: null));
    return true;
  }

  int getSelectedFilterCount() {
    int selectedFilterCount = [
      state.selectedBodyTypes,
      state.selectedTransmissionTypes,
      state.selectedFuelTypes,
      state.selectedColors,
    ].fold(0, (sum, list) => sum + list.length);

    final fields = [
      state.selectedMinYear,
      state.selectedMaxYear,
      state.selectedMinPrice,
      state.selectedMaxPrice,
    ];

    selectedFilterCount += fields.where((v) => (v?.isNotEmpty ?? false)).length;

    return selectedFilterCount;
  }

  @override
  Future<void> close() async {
    await _carSubscription?.cancel();
    await super.close();
  }
}
