import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_futter_project/domain/models/field_params_model.dart';
import 'package:test_futter_project/presentation/bloc/home/new_item_page/new_item_page_state.dart';

import '../../../../di/injection_container.dart';
import '../../../../l10n/l10n_keys.dart';
import '../../l10n/app_localisations_cubit.dart';

class NewItemPageCubit extends Cubit<NewItemPageState> {
  NewItemPageCubit() : super(const NewItemPageState());

  void init() {
    emit(
      state.copyWith(
        manufacturerFieldParams: FieldParamsModel.withLabel('Manufacturer *').copyWith(
          validationMessage: serviceLocator<AppLocalisationsCubit>().getLocalisationByKey(
            L10nKeys.fieldParamsValidationMessage,
          ),
          regexErrorMessage: 'Please, enter a valid manufacturer.',
          regex: r'^[A-Za-z\s\-]+$',
        ),
        modelFieldParams: FieldParamsModel.withLabel('Model *').copyWith(
          validationMessage: serviceLocator<AppLocalisationsCubit>().getLocalisationByKey(
            L10nKeys.fieldParamsValidationMessage,
          ),
          regexErrorMessage: 'Please, enter a valid model.',
          regex: r'^[A-Za-z0-9\s\-\/\+]+$',
        ),
        yearFieldParams: FieldParamsModel.withLabel('Year *').copyWith(
          validationMessage: serviceLocator<AppLocalisationsCubit>().getLocalisationByKey(
            L10nKeys.fieldParamsValidationMessage,
          ),
          regexErrorMessage: 'Please, enter a valid year.',
          regex: r'^(198[0-9]|199[0-9]|200[0-9]|201[0-9]|202[0-6])$',
        ),
        colorFieldParams: FieldParamsModel.withLabel('Color *').copyWith(
          validationMessage: serviceLocator<AppLocalisationsCubit>().getLocalisationByKey(
            L10nKeys.fieldParamsValidationMessage,
          ),
          regexErrorMessage: 'Please, enter a valid color.',
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

    return true;
  }

  void updateTabIndex(int newIndex) {
    emit(state.copyWith(currentPageIndex: newIndex));
  }

  bool areAllFieldsValid(String manufacturer, String model, String year, String color) {
    bool result = true;

    final isManufacturerValid = validateManufacturer(manufacturer, false);
    if (!isManufacturerValid) {
      result = false;
    }

    final isModelValid = validateModel(model, false);
    if (!isModelValid) {
      result = false;
    }

    final isYearValid = validateYear(year, false);
    if (!isYearValid) {
      result = false;
    }

    final isColorValid = validateColor(color, false);
    if (!isColorValid) {
      result = false;
    }

    return result;
  }
}
