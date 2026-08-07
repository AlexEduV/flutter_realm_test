import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_flutter_project/domain/usecases/car_colors/get_car_color_name_from_color_use_case.dart';
import 'package:test_flutter_project/domain/usecases/car_colors/get_car_colors_use_case.dart';
import 'package:test_flutter_project/presentation/features/color_picker/color_picker_state.dart';

import '../../../domain/usecases/car_colors/get_car_color_by_name_use_case.dart';

class ColorPickerCubit extends Cubit<ColorPickerState> {
  ColorPickerCubit(
    this._getCarColorsUseCase,
    this._getCarColorByNameUseCase,
    this._getCarColorNameFromColorUseCase,
  ) : super(const ColorPickerState());

  final GetCarColorsUseCase _getCarColorsUseCase;
  final GetCarColorByNameUseCase _getCarColorByNameUseCase;
  final GetCarColorNameFromColorUseCase _getCarColorNameFromColorUseCase;

  void loadColors() {
    final colors = _getCarColorsUseCase.call();
    emit(state.copyWith(colors: colors));
  }

  void updatePickedColor(Color? newColor) {
    emit(state.copyWith(pickedColor: newColor));
  }

  Color? getColorByName(String name) {
    final color = _getCarColorByNameUseCase.call(name);
    return color;
  }

  String getColorNameFromColor(Color? color) {
    final colorName = _getCarColorNameFromColorUseCase.call(color);
    return colorName;
  }
}
