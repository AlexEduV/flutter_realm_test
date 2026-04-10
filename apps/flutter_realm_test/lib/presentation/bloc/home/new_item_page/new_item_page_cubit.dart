import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_futter_project/common/enums/body_type.dart';
import 'package:test_futter_project/common/enums/car_type.dart';
import 'package:test_futter_project/common/enums/fuel_type.dart';
import 'package:test_futter_project/common/enums/transmission_type.dart';
import 'package:test_futter_project/domain/models/field_params_model.dart';
import 'package:test_futter_project/domain/usecases/auto_complete/get_auto_complete_manufacturers_by_type_use_case.dart';
import 'package:test_futter_project/presentation/bloc/home/new_item_page/new_item_page_state.dart';

import '../../../../core/di/injection_container.dart';
import '../../../../l10n/l10n_keys.dart';
import '../../l10n/app_localisations_cubit.dart';

class NewItemPageCubit extends Cubit<NewItemPageState> {
  final GetAutoCompleteManufacturersByTypeUseCase _autoCompleteManufacturersByTypeUseCase;

  NewItemPageCubit(this._autoCompleteManufacturersByTypeUseCase) : super(const NewItemPageState());

  void init() {
    emit(
      state.copyWith(
        manufacturerFieldParams:
            FieldParamsModel.withLabel(
              serviceLocator<AppLocalisationsCubit>().getLocalisationByKey(
                L10nKeys.fieldParamsManufacturerLabel,
              ),
            ).copyWith(
              validationMessage: serviceLocator<AppLocalisationsCubit>().getLocalisationByKey(
                L10nKeys.fieldParamsValidationMessage,
              ),
              regexErrorMessage: serviceLocator<AppLocalisationsCubit>().getLocalisationByKey(
                L10nKeys.fieldParamsManufacturerRegexErrorMessage,
              ),
              regex: r'^[A-Za-z\s\-]+$',
            ),
        modelFieldParams:
            FieldParamsModel.withLabel(
              serviceLocator<AppLocalisationsCubit>().getLocalisationByKey(
                L10nKeys.fieldParamsVehicleModelLabel,
              ),
            ).copyWith(
              validationMessage: serviceLocator<AppLocalisationsCubit>().getLocalisationByKey(
                L10nKeys.fieldParamsValidationMessage,
              ),
              regexErrorMessage: serviceLocator<AppLocalisationsCubit>().getLocalisationByKey(
                L10nKeys.fieldParamsVehicleModelRegexErrorMessage,
              ),
              regex: r'^[A-Za-z0-9\s\-\/\+]+$',
            ),
        yearFieldParams:
            FieldParamsModel.withLabel(
              serviceLocator<AppLocalisationsCubit>().getLocalisationByKey(
                L10nKeys.fieldParamsYearOfProductionLabel,
              ),
            ).copyWith(
              validationMessage: serviceLocator<AppLocalisationsCubit>().getLocalisationByKey(
                L10nKeys.fieldParamsValidationMessage,
              ),
              regexErrorMessage: serviceLocator<AppLocalisationsCubit>().getLocalisationByKey(
                L10nKeys.fieldParamsYearOfProductionRegexErrorMessage,
              ),
              regex: r'^(198[0-9]|199[0-9]|200[0-9]|201[0-9]|202[0-6])$',
            ),
        priceFieldParams:
            FieldParamsModel.withLabel(
              serviceLocator<AppLocalisationsCubit>().getLocalisationByKey(
                L10nKeys.fieldParamsPriceLabel,
              ),
            ).copyWith(
              validationMessage: serviceLocator<AppLocalisationsCubit>().getLocalisationByKey(
                L10nKeys.fieldParamsValidationMessage,
              ),
              regexErrorMessage: serviceLocator<AppLocalisationsCubit>().getLocalisationByKey(
                L10nKeys.fieldParamsPriceRegexErrorMessage,
              ),
              regex: r'^(0|[1-9]\d{0,7})$',
            ),
        colorFieldParams:
            FieldParamsModel.withLabel(
              serviceLocator<AppLocalisationsCubit>().getLocalisationByKey(
                L10nKeys.fieldParamsColorLabel,
              ),
            ).copyWith(
              validationMessage: serviceLocator<AppLocalisationsCubit>().getLocalisationByKey(
                L10nKeys.fieldParamsValidationMessage,
              ),
              regexErrorMessage: serviceLocator<AppLocalisationsCubit>().getLocalisationByKey(
                L10nKeys.fieldParamsColorRegexErrorMessage,
              ),
              regex: r'^[A-Za-z\s\-]+$',
            ),
      ),
    );
  }

  bool validateManufacturer(String manufacturer, bool isEditing) {
    if (isEditing) {
      emit(state.copyWith(manufacturerErrorText: null));
      return true;
    }

    if (manufacturer.isEmpty) {
      emit(state.copyWith(manufacturerErrorText: state.manufacturerFieldParams?.validationMessage));
      return false;
    }

    final manufacturerRegex = RegExp(state.manufacturerFieldParams?.regex ?? '');
    if (!manufacturerRegex.hasMatch(manufacturer)) {
      emit(state.copyWith(manufacturerErrorText: state.manufacturerFieldParams?.regexErrorMessage));
      return false;
    }

    emit(state.copyWith(manufacturerErrorText: null));
    return true;
  }

  bool validateModel(String model, bool isEditing) {
    if (isEditing) {
      emit(state.copyWith(modelErrorText: null));
      return true;
    }

    if (model.isEmpty) {
      emit(state.copyWith(modelErrorText: state.modelFieldParams?.validationMessage));
      return false;
    }

    final modelRegex = RegExp(state.modelFieldParams?.regex ?? '');
    if (!modelRegex.hasMatch(model)) {
      emit(state.copyWith(modelErrorText: state.modelFieldParams?.regexErrorMessage));
      return false;
    }

    emit(state.copyWith(modelErrorText: null));
    return true;
  }

  bool validateYear(String year, bool isEditing) {
    if (isEditing) {
      emit(state.copyWith(yearErrorText: null));
      return true;
    }

    if (year.isEmpty) {
      emit(state.copyWith(yearErrorText: state.yearFieldParams?.validationMessage));
      return false;
    }

    final yearRegex = RegExp(state.yearFieldParams?.regex ?? '');
    if (!yearRegex.hasMatch(year)) {
      emit(state.copyWith(yearErrorText: state.yearFieldParams?.regexErrorMessage));
      return false;
    }

    emit(state.copyWith(yearErrorText: null));
    return true;
  }

  bool validatePrice(String price, bool isEditing) {
    if (isEditing) {
      emit(state.copyWith(priceErrorText: null));
      return true;
    }

    if (price.isEmpty) {
      emit(state.copyWith(priceErrorText: state.priceFieldParams?.validationMessage));
      return false;
    }

    final priceRegex = RegExp(state.priceFieldParams?.regex ?? '');
    if (!priceRegex.hasMatch(price)) {
      emit(state.copyWith(priceErrorText: state.priceFieldParams?.regexErrorMessage));
      return false;
    }

    emit(state.copyWith(priceErrorText: null));
    return true;
  }

  bool validateColor(String color, bool isEditing) {
    if (isEditing) {
      emit(state.copyWith(colorErrorText: null));
      return true;
    }

    if (color.isEmpty) {
      emit(state.copyWith(colorErrorText: state.colorFieldParams?.validationMessage));
      return false;
    }

    final colorRegex = RegExp(state.colorFieldParams?.regex ?? '');
    if (!colorRegex.hasMatch(color)) {
      emit(state.copyWith(colorErrorText: state.colorFieldParams?.regexErrorMessage));
      return false;
    }

    emit(state.copyWith(colorErrorText: null));
    return true;
  }

  void updateTabIndex(int newIndex) {
    emit(state.copyWith(currentPageIndex: newIndex));
  }

  bool areAllFieldsValid() {
    bool result = true;

    final isManufacturerValid = validateManufacturer(state.manufacturerText, false);
    if (!isManufacturerValid) {
      result = false;
    }

    final isModelValid = validateModel(state.modelText, false);
    if (!isModelValid) {
      result = false;
    }

    final isYearValid = validateYear(state.yearText, false);
    if (!isYearValid) {
      result = false;
    }

    final isPriceValid = validatePrice(state.priceText, false);
    if (!isPriceValid) {
      result = false;
    }

    final isColorValid = validateColor(state.colorText, false);
    if (!isColorValid) {
      result = false;
    }

    return result;
  }

  void updateSelectedCarType(CarType? newType) {
    emit(state.copyWith(selectedCarType: newType ?? CarType.car));
  }

  void updateManufacturerText(String newText) {
    emit(state.copyWith(manufacturerText: newText));
  }

  void updateModelText(String newText) {
    emit(state.copyWith(modelText: newText));
  }

  void updateYearText(String newText) {
    emit(state.copyWith(yearText: newText));
  }

  void updatePriceText(String newPrice) {
    emit(state.copyWith(priceText: newPrice));
  }

  void updateColorText(String newText) {
    emit(state.copyWith(colorText: newText));
  }

  void updateSelectedBodyType(BodyType? newType) {
    emit(state.copyWith(selectedBodyType: newType));
  }

  void updateSelectedTransmissionType(TransmissionType? newType) {
    emit(state.copyWith(selectedTransmissionType: newType ?? TransmissionType.manual));
  }

  void updateSelectedFuelType(FuelType? newType) {
    emit(state.copyWith(selectedFuelType: newType ?? FuelType.diesel));
  }

  void clearInfoForm() {
    emit(
      state.copyWith(
        manufacturerText: '',
        modelText: '',
        yearText: '',
        colorText: '',
        priceText: '',
      ),
    );
  }

  Future<void> getAutoCompleteEntitiesByType(CarType type) async {
    final result = await _autoCompleteManufacturersByTypeUseCase.call(type);
    emit(state.copyWith(autoCompleteEntities: result));
  }

  void clearFieldErrors() {
    emit(
      state.copyWith(
        manufacturerErrorText: null,
        modelErrorText: null,
        yearErrorText: null,
        priceErrorText: null,
        colorErrorText: null,
      ),
    );
  }
}
