import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_flutter_project/domain/repositories/car_color_repository.dart';
import 'package:test_flutter_project/domain/usecases/database/get_car_by_id_use_case.dart';
import 'package:test_flutter_project/domain/usecases/inbox/get_conversation_by_owner_id_use_case.dart';

import 'details_page_state.dart';

class DetailsPageCubit extends Cubit<DetailsPageState> {
  DetailsPageCubit(
    this._carColorRepository,
    this._getCarByIdUseCase,
    this._getConversationByOwnerIdUseCase,
  ) : super(const DetailsPageState());

  final CarColorRepository _carColorRepository;
  final GetCarByIdUseCase _getCarByIdUseCase;
  final GetConversationByOwnerIdUseCase _getConversationByOwnerIdUseCase;

  void loadData(String carId) {
    final entity = _getCarByIdUseCase.call(carId);
    final normalized = entity?.color?.toLowerCase().replaceAll(' ', '') ?? '';
    final carColor = _carColorRepository
        .getColors()
        .entries
        .firstWhereOrNull((e) => e.key.toLowerCase() == normalized)
        ?.value;

    emit(state.copyWith(car: entity, carColor: carColor));
  }

  void setVehicleSpecsExpansionState(bool newState) {
    emit(state.copyWith(isVehicleSpecsExpanded: newState));
  }

  String getConversationId(String ownerId) {
    return _getConversationByOwnerIdUseCase.call(ownerId).conversationId;
  }
}
