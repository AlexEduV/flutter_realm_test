import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart' show Cubit;
import 'package:test_futter_project/common/enums/car_type.dart';
import 'package:test_futter_project/common/enums/drawer_type.dart';
import 'package:test_futter_project/domain/entities/car_entity.dart';
import 'package:test_futter_project/domain/models/field_params_model.dart';
import 'package:test_futter_project/domain/usecases/database/get_all_cars_use_case.dart';
import 'package:test_futter_project/domain/usecases/database/watch_cars_use_case.dart';
import 'package:test_futter_project/presentation/bloc/search/search_page_state.dart';

class SearchPageCubit extends Cubit<SearchPageState> {
  SearchPageCubit(this._getAllCarsUseCase, this._watchCarsUseCase) : super(const SearchPageState());

  StreamSubscription? _carSubscription;

  final GetAllCarsUseCase _getAllCarsUseCase;
  final WatchCarsUseCase _watchCarsUseCase;

  void init() {
    emit(
      state.copyWith(
        minYearFieldParamsModel: FieldParamsModel.withLabel(
          'Min:',
        ).copyWith(validationMessage: 'Incorrect value'),
        maxYearFieldParamsModel: FieldParamsModel.withLabel(
          'Max:',
        ).copyWith(validationMessage: 'Incorrect value'),
        minPriceFieldParamsModel: FieldParamsModel.withLabel(
          'Min:',
        ).copyWith(validationMessage: 'Incorrect value'),
        maxPriceFieldParamsModel: FieldParamsModel.withLabel(
          'Max:',
        ).copyWith(validationMessage: 'Incorrect value'),
      ),
    );

    loadData();
  }

  void loadData() {
    emit(state.copyWith(isLoading: true));

    final results = applyAllFilters(_getAllCarsUseCase.call());

    updateModelListFromEntities(results, state.currentSelectedType);

    emit(state.copyWith(allResults: results, isLoading: false));

    _carSubscription = _watchCarsUseCase.call()?.listen((entities) {
      final results = applyAllFilters(entities);
      emit(state.copyWith(results: results));
    });
  }

  List<CarEntity> applyAllFilters(List<CarEntity> cars) {
    return cars.where((car) {
      // Year filter
      final minYear = int.tryParse(state.selectedMinYear ?? '');
      final carYear = int.tryParse(car.year ?? '');
      if (minYear != null && (carYear ?? 0) < minYear) {
        return false;
      }

      final maxYear = int.tryParse(state.selectedMaxYear ?? '');
      if (maxYear != null && (carYear ?? 0) > maxYear) {
        return false;
      }

      // Price filter
      final minPrice = int.tryParse(state.selectedMinPrice ?? '');
      if (minPrice != null && (car.price ?? 0) < minPrice) {
        return false;
      }

      final maxPrice = int.tryParse(state.selectedMaxPrice ?? '');
      if (maxPrice != null && (car.price ?? 0) > maxPrice) {
        return false;
      }

      // Type filter
      if (car.type != state.currentSelectedType.name) {
        return false;
      }
      // Model filter
      if (state.selectedModels.isNotEmpty &&
          !state.selectedModels.contains('${car.manufacturer} ${car.model}')) {
        return false;
      }
      // Body type filter
      if (state.selectedBodyTypes.isNotEmpty && !state.selectedBodyTypes.contains(car.bodyType)) {
        return false;
      }
      // Fuel type filter
      if (state.selectedFuelTypes.isNotEmpty && !state.selectedFuelTypes.contains(car.fuelType)) {
        return false;
      }
      // Transmission type filter
      if (state.selectedTransmissionTypes.isNotEmpty &&
          !state.selectedTransmissionTypes.contains(car.transmissionType)) {
        return false;
      }

      // Add more filters here as needed
      return true;
    }).toList();
  }

  void updateTypeSelection(CarType newType) {
    //todo: maybe better to save Map<> for each type, so the user can easily switch between tabs
    updateModelListFromEntities(state.results, newType);

    emit(state.copyWith(currentSelectedType: newType, selectedModels: [], selectedBodyTypes: []));
  }

  void updateModelListFromEntities(List<CarEntity> cars, CarType type) {
    final allModels = cars
        .where((element) => element.type == state.currentSelectedType.name)
        .map((element) => '${element.manufacturer} ${element.model}')
        .toSet()
        .toList();
    emit(state.copyWith(allModels: allModels));
  }

  void updateModelSelection(List<String> newList) {
    emit(state.copyWith(selectedModels: newList));

    emit(state.copyWith(results: applyAllFilters(state.allResults)));
  }

  void addCarModelToSelection(String model) {
    final newSelection = List<String>.from(state.selectedModels)..add(model);
    emit(state.copyWith(selectedModels: newSelection));

    emit(state.copyWith(results: applyAllFilters(state.allResults)));
  }

  void removeCarModelFromSelection(String model) {
    final newSelection = List<String>.from(state.selectedModels)..remove(model);
    emit(state.copyWith(selectedModels: newSelection));

    emit(state.copyWith(results: applyAllFilters(state.allResults)));
  }

  void addBodyTypeToSelection(String bodyType) {
    final newSelection = List<String>.from(state.selectedBodyTypes)..add(bodyType);
    emit(state.copyWith(selectedBodyTypes: newSelection));

    emit(state.copyWith(results: applyAllFilters(state.allResults)));
  }

  void removeBodyTypeFromSelection(String bodyType) {
    final newSelection = List<String>.from(state.selectedBodyTypes)..remove(bodyType);
    emit(state.copyWith(selectedBodyTypes: newSelection));

    emit(state.copyWith(results: applyAllFilters(state.allResults)));
  }

  void addFuelTypeToSelection(String fuelType) {
    final newSelection = List<String>.from(state.selectedFuelTypes)..add(fuelType);
    emit(state.copyWith(selectedFuelTypes: newSelection));

    emit(state.copyWith(results: applyAllFilters(state.allResults)));
  }

  void removeFuelTypeFromSelection(String fuelType) {
    final newSelection = List<String>.from(state.selectedFuelTypes)..remove(fuelType);
    emit(state.copyWith(selectedFuelTypes: newSelection));

    emit(state.copyWith(results: applyAllFilters(state.allResults)));
  }

  void addTransmissionTypeToSelection(String transmissionType) {
    final newSelection = List<String>.from(state.selectedTransmissionTypes)..add(transmissionType);
    emit(state.copyWith(selectedTransmissionTypes: newSelection));

    emit(state.copyWith(results: applyAllFilters(state.allResults)));
  }

  void removeTransmissionTypeFromSelection(String transmissionType) {
    final newSelection = List<String>.from(state.selectedTransmissionTypes)
      ..remove(transmissionType);
    emit(state.copyWith(selectedTransmissionTypes: newSelection));

    emit(state.copyWith(results: applyAllFilters(state.allResults)));
  }

  void updateSelectedMinYear(String newValue) {
    emit(state.copyWith(selectedMinYear: newValue));
    validateYears(state.selectedMinYear, state.selectedMaxYear);

    applyAllFilters(state.allResults);
  }

  void updateSelectedMaxYear(String newValue) {
    emit(state.copyWith(selectedMaxYear: newValue));
    validateYears(state.selectedMinYear, state.selectedMaxYear);

    applyAllFilters(state.allResults);
  }

  void updateSelectedMinPrice(String newValue) {
    emit(state.copyWith(selectedMinPrice: newValue));
    validatePrices(state.selectedMinPrice, state.selectedMaxPrice);

    applyAllFilters(state.allResults);
  }

  void updateSelectedMaxPrice(String newValue) {
    emit(state.copyWith(selectedMaxPrice: newValue));
    validatePrices(state.selectedMinPrice, state.selectedMaxPrice);

    applyAllFilters(state.allResults);
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
  Future<void> close() {
    _carSubscription?.cancel();
    return super.close();
  }
}
