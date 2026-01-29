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

    emit(state.copyWith(results: results, isLoading: false));

    _carSubscription = _carRepository.watchCars()?.listen((entities) {
      emit(state.copyWith(results: filterCarsByType(entities)));
    });
  }

  void updateTypeSelection(CarType newType) {
    emit(state.copyWith(currentSelectedType: newType));
  }

  List<CarEntity> filterCarsByType(List<CarEntity> list) {
    return list.where((car) => car.type == state.currentSelectedType.name).toList();
  }

  List<String> getModelsFromEntities(List<CarEntity> cars) {
    return cars.map((element) => '${element.manufacturer} ${element.model}').toSet().toList();
  }

  void updateModelSelection(List<String> newList) {
    emit(state.copyWith(selectedModels: newList));
  }

  void addCarModelToSelection(String model) {
    final newSelection = List<String>.from(state.selectedModels)..add(model);
    emit(state.copyWith(selectedModels: newSelection));
  }

  void removeCarModelFromSelection(String model) {
    final newSelection = List<String>.from(state.selectedModels)..remove(model);
    emit(state.copyWith(selectedModels: newSelection));
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
