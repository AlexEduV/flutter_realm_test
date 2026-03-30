import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:test_futter_project/common/app_constants.dart';
import 'package:test_futter_project/common/enums/car_type.dart';
import 'package:test_futter_project/common/enums/fuel_type.dart';
import 'package:test_futter_project/common/enums/transmission_type.dart';
import 'package:test_futter_project/domain/models/field_params_model.dart';

import '../../../../common/enums/body_type.dart';

part 'new_item_page_state.freezed.dart';

@freezed
abstract class NewItemPageState with _$NewItemPageState {
  const factory NewItemPageState({
    FieldParamsModel? manufacturerFieldParams,
    FieldParamsModel? modelFieldParams,
    FieldParamsModel? yearFieldParams,
    FieldParamsModel? colorFieldParams,
    FieldParamsModel? priceFieldParams,
    String? manufacturerErrorText,
    String? modelErrorText,
    String? yearErrorText,
    String? colorErrorText,
    String? priceErrorText,
    @Default('') String manufacturerText,
    @Default('') String modelText,
    @Default('') String yearText,
    @Default('') String colorText,
    @Default('') String priceText,
    @Default(AppConstants.itemSetupTabType) int currentPageIndex,
    @Default(CarType.car) CarType selectedCarType,
    BodyType? selectedBodyType,
    @Default(FuelType.diesel) FuelType selectedFuelType,
    @Default(TransmissionType.manual) TransmissionType selectedTransmissionType,
  }) = _NewItemPageState;
}
