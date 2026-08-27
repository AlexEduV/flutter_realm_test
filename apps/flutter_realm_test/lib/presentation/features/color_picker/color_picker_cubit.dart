import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_flutter_project/domain/repositories/car_color_repository.dart';
import 'package:test_flutter_project/presentation/features/color_picker/color_picker_state.dart';

class ColorPickerCubit extends Cubit<ColorPickerState> {
  ColorPickerCubit(this._carColorRepository) : super(const ColorPickerState());

  final CarColorRepository _carColorRepository;

  void loadColors() {
    final colors = _carColorRepository.getColors();
    emit(state.copyWith(colors: colors));
  }

  void updatePickedColor(Color? newColor) {
    emit(state.copyWith(pickedColor: newColor));
  }

  Color? getColorByName(String name) {
    final color = _carColorRepository.getColorByName(name);
    return color;
  }

  String getColorNameFromColor(Color? color) {
    final colorName = _carColorRepository.getColorNameFromColor(color);
    return colorName;
  }
}
