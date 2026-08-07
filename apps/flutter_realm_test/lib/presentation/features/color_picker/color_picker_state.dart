import 'dart:ui';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'color_picker_state.freezed.dart';

@freezed
abstract class ColorPickerState with _$ColorPickerState {
  const factory ColorPickerState({@Default({}) Map<String, Color> colors, Color? pickedColor}) =
      _ColorPickerState;
}
