import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_futter_project/domain/entities/car_entity.dart';
import 'package:test_futter_project/domain/repositories/car_repository.dart';
import 'package:test_futter_project/presentation/bloc/home/home_page_state.dart';

class HomePageCubit extends Cubit<HomePageState> {
  HomePageCubit(this._carRepository) : super(HomePageState());

  final CarRepository _carRepository;
  StreamSubscription? _carSubscription;

  Future<void> init() async {
    emit(state.copyWith(isLoading: true));

    await _carRepository.syncCars();

    emit(state.copyWith(isLoading: false));

    _carSubscription = _carRepository.watchCars()?.listen((entities) {
      emit(state.copyWith(cars: entities));
    });
  }

  void updateCars(List<CarEntity> newValue) {
    emit(state.copyWith(cars: newValue));
  }

  void removeCarAt(int index) {
    final cars = List<CarEntity>.from(state.cars);
    cars.removeAt(index);

    emit(state.copyWith(cars: cars));
  }

  @override
  Future<void> close() {
    _carSubscription?.cancel();
    return super.close();
  }
}
