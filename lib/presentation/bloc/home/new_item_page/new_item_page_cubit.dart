import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_futter_project/domain/models/field_params_model.dart';
import 'package:test_futter_project/presentation/bloc/home/new_item_page/new_item_page_state.dart';

class NewItemPageCubit extends Cubit<NewItemPageState> {
  NewItemPageCubit() : super(const NewItemPageState());

  void init() {
    emit(
      state.copyWith(
        manufacturerFieldParams: FieldParamsModel.withLabel('Manufacturer *'),
        modelFieldParams: FieldParamsModel.withLabel('Model *'),
        yearFieldParams: FieldParamsModel.withLabel('Year *'),
        colorFieldParams: FieldParamsModel.withLabel('Color *'),
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
}
