import 'package:flutter_bloc/flutter_bloc.dart' show Cubit;
import 'package:test_futter_project/common/enums/car_type.dart';
import 'package:test_futter_project/domain/repositories/car_repository.dart';
import 'package:test_futter_project/presentation/bloc/search/search_page_state.dart';

class SearchPageCubit extends Cubit<SearchPageState> {
  SearchPageCubit(this._carRepository) : super(SearchPageState());

  final CarRepository _carRepository;

  void loadData() {
    emit(state.copyWith(isLoading: true));

    final results = _carRepository
        .getAllCars()
        .where((car) => car.type == state.currentSelectedType.name)
        .toList();

    emit(state.copyWith(results: results, isLoading: false));
  }

  void updateTypeSelection(CarType newType) {
    emit(state.copyWith(currentSelectedType: newType));
  }
}
