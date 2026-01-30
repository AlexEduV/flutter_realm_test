import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart' show Cubit;
import 'package:test_futter_project/common/enums/car_type.dart';
import 'package:test_futter_project/common/enums/drawer_type.dart';
import 'package:test_futter_project/domain/entities/car_entity.dart';
import 'package:test_futter_project/domain/repositories/car_repository.dart';
import 'package:test_futter_project/presentation/bloc/search/search_page_state.dart';

class SearchPageCubit extends Cubit<SearchPageState> {
  SearchPageCubit(this._carRepository) : super(SearchPageState());

  final CarRepository _carRepository;
  StreamSubscription? _carSubscription;

  void loadData() {
    emit(state.copyWith(isLoading: true));

    final results = filterCarsByType(_carRepository.getAllCars());

    updateModelListFromEntities(results, state.currentSelectedType);

    emit(state.copyWith(results: results, isLoading: false));

    _carSubscription = _carRepository.watchCars()?.listen((entities) {
      final resultsByType = filterCarsByType(entities);
      final resultsByModel = filterCarsByModel(resultsByType);

      emit(state.copyWith(results: resultsByModel));
    });
  }

  void updateTypeSelection(CarType newType) {
    //todo: maybe better to save Map<> for each type, so the user can easily switch between tabs
    updateModelListFromEntities(state.results, newType);

    emit(state.copyWith(currentSelectedType: newType, selectedModels: []));
  }

  List<CarEntity> filterCarsByType(List<CarEntity> list) {
    return list.where((car) => car.type == state.currentSelectedType.name).toList();
  }

  List<CarEntity> filterCarsByModel(List<CarEntity> list) {
    if (state.selectedModels.isEmpty) {
      return list;
    }

    return list
        .where((car) => state.selectedModels.contains('${car.manufacturer} ${car.model}'))
        .toList();
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

    emit(state.copyWith(results: filterCarsByModel(state.results)));
  }

  void addCarModelToSelection(String model) {
    final newSelection = List<String>.from(state.selectedModels)..add(model);
    emit(state.copyWith(selectedModels: newSelection));

    emit(state.copyWith(results: filterCarsByModel(state.results)));
  }

  void removeCarModelFromSelection(String model) {
    final newSelection = List<String>.from(state.selectedModels)..remove(model);
    emit(state.copyWith(selectedModels: newSelection));

    emit(state.copyWith(results: filterCarsByModel(state.results)));
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
