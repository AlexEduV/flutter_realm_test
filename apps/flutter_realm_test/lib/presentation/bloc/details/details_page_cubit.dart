import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_futter_project/domain/usecases/database/get_car_by_id_use_case.dart';
import 'package:test_futter_project/presentation/bloc/details/details_page_state.dart';

class DetailsPageCubit extends Cubit<DetailsPageState> {
  final GetCarByIdUseCase getCarByIdUseCase;

  DetailsPageCubit(this.getCarByIdUseCase) : super(const DetailsPageState());

  void loadData(String id) {
    final entity = getCarByIdUseCase.call(id);
    emit(state.copyWith(car: entity));
  }

  void setVehicleSpecsExpansionState(bool newState) {
    emit(state.copyWith(isVehicleSpecsExpanded: newState));
  }
}
