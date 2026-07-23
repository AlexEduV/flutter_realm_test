import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_flutter_project/domain/usecases/car_colors/get_car_colors_use_case.dart';
import 'package:test_flutter_project/domain/usecases/database/get_car_by_id_use_case.dart';
import 'package:test_flutter_project/presentation/bloc/details/details_page_state.dart';

class DetailsPageCubit extends Cubit<DetailsPageState> {
  DetailsPageCubit(this._getCarByIdUseCase, this._getCarColorsUseCase)
    : super(const DetailsPageState());

  final GetCarByIdUseCase _getCarByIdUseCase;
  final GetCarColorsUseCase _getCarColorsUseCase;

  void loadData(String id) {
    final entity = _getCarByIdUseCase.call(id);
    final normalized = entity.color?.toLowerCase().replaceAll(' ', '') ?? '';
    final carColor = _getCarColorsUseCase.call().entries
        .firstWhereOrNull((e) => e.key.toLowerCase() == normalized)
        ?.value;

    emit(state.copyWith(car: entity, carColor: carColor));
  }

  void setVehicleSpecsExpansionState(bool newState) {
    emit(state.copyWith(isVehicleSpecsExpanded: newState));
  }
}
