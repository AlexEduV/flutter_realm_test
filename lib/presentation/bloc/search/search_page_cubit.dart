import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart' show Cubit;
import 'package:test_futter_project/common/enums/car_type.dart';
import 'package:test_futter_project/common/enums/drawer_type.dart';
import 'package:test_futter_project/domain/entities/car_entity.dart';
import 'package:test_futter_project/domain/usecases/database/get_all_cars_use_case.dart';
import 'package:test_futter_project/domain/usecases/database/watch_cars_use_case.dart';
import 'package:test_futter_project/presentation/bloc/search/search_page_state.dart';

class SearchPageCubit extends Cubit<SearchPageState> {
  SearchPageCubit(this._getAllCarsUseCase, this._watchCarsUseCase) : super(const SearchPageState());

  StreamSubscription? _carSubscription;

  final GetAllCarsUseCase _getAllCarsUseCase;
  final WatchCarsUseCase _watchCarsUseCase;

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

  void addFuelTypeToSelection(String bodyType) {
    final newSelection = List<String>.from(state.selectedFuelTypes)..add(bodyType);
    emit(state.copyWith(selectedFuelTypes: newSelection));

    emit(state.copyWith(results: applyAllFilters(state.allResults)));
  }

  void removeFuelTypeFromSelection(String bodyType) {
    final newSelection = List<String>.from(state.selectedFuelTypes)..remove(bodyType);
    emit(state.copyWith(selectedFuelTypes: newSelection));

    emit(state.copyWith(results: applyAllFilters(state.allResults)));
  }

  void openDrawer(SearchDrawerType type) {
    emit(state.copyWith(drawerOpened: type));
  }

  @override
  Future<void> close() {
    _carSubscription?.cancel();
    return super.close();
  }
}
