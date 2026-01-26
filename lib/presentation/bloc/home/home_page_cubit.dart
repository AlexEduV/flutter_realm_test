import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_futter_project/domain/repositories/car_repository.dart';
import 'package:test_futter_project/presentation/bloc/home/home_page_state.dart';

import '../../../data/models/scheme.dart';

class HomePageCubit extends Cubit<HomePageState> {
  HomePageCubit(this._carRepository) : super(HomePageState());

  final CarRepository _carRepository;

  void init() {
    final cars = _carRepository.getAllCars();
    emit(state.copyWith(cars: cars));
  }

  void updateCars(List<Car> newValue) {
    emit(state.copyWith(cars: newValue));
  }

  void removeCarAt(int index) {
    final cars = List<Car>.from(state.cars);
    cars.removeAt(index);

    emit(state.copyWith(cars: cars));
  }
}
