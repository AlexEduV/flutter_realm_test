// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'color_picker_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ColorPickerState {
  Map<String, Color> get colors;
  Color? get pickedColor;

  /// Create a copy of ColorPickerState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ColorPickerStateCopyWith<ColorPickerState> get copyWith =>
      _$ColorPickerStateCopyWithImpl<ColorPickerState>(
          this as ColorPickerState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ColorPickerState &&
            const DeepCollectionEquality().equals(other.colors, colors) &&
            (identical(other.pickedColor, pickedColor) ||
                other.pickedColor == pickedColor));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(colors), pickedColor);

  @override
  String toString() {
    return 'ColorPickerState(colors: $colors, pickedColor: $pickedColor)';
  }
}

/// @nodoc
abstract mixin class $ColorPickerStateCopyWith<$Res> {
  factory $ColorPickerStateCopyWith(
          ColorPickerState value, $Res Function(ColorPickerState) _then) =
      _$ColorPickerStateCopyWithImpl;
  @useResult
  $Res call({Map<String, Color> colors, Color? pickedColor});
}

/// @nodoc
class _$ColorPickerStateCopyWithImpl<$Res>
    implements $ColorPickerStateCopyWith<$Res> {
  _$ColorPickerStateCopyWithImpl(this._self, this._then);

  final ColorPickerState _self;
  final $Res Function(ColorPickerState) _then;

  /// Create a copy of ColorPickerState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? colors = null,
    Object? pickedColor = freezed,
  }) {
    return _then(_self.copyWith(
      colors: null == colors
          ? _self.colors
          : colors // ignore: cast_nullable_to_non_nullable
              as Map<String, Color>,
      pickedColor: freezed == pickedColor
          ? _self.pickedColor
          : pickedColor // ignore: cast_nullable_to_non_nullable
              as Color?,
    ));
  }
}

/// @nodoc

class _ColorPickerState implements ColorPickerState {
  const _ColorPickerState(
      {final Map<String, Color> colors = const {}, this.pickedColor})
      : _colors = colors;

  final Map<String, Color> _colors;
  @override
  @JsonKey()
  Map<String, Color> get colors {
    if (_colors is EqualUnmodifiableMapView) return _colors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_colors);
  }

  @override
  final Color? pickedColor;

  /// Create a copy of ColorPickerState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ColorPickerStateCopyWith<_ColorPickerState> get copyWith =>
      __$ColorPickerStateCopyWithImpl<_ColorPickerState>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ColorPickerState &&
            const DeepCollectionEquality().equals(other._colors, _colors) &&
            (identical(other.pickedColor, pickedColor) ||
                other.pickedColor == pickedColor));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_colors), pickedColor);

  @override
  String toString() {
    return 'ColorPickerState(colors: $colors, pickedColor: $pickedColor)';
  }
}

/// @nodoc
abstract mixin class _$ColorPickerStateCopyWith<$Res>
    implements $ColorPickerStateCopyWith<$Res> {
  factory _$ColorPickerStateCopyWith(
          _ColorPickerState value, $Res Function(_ColorPickerState) _then) =
      __$ColorPickerStateCopyWithImpl;
  @override
  @useResult
  $Res call({Map<String, Color> colors, Color? pickedColor});
}

/// @nodoc
class __$ColorPickerStateCopyWithImpl<$Res>
    implements _$ColorPickerStateCopyWith<$Res> {
  __$ColorPickerStateCopyWithImpl(this._self, this._then);

  final _ColorPickerState _self;
  final $Res Function(_ColorPickerState) _then;

  /// Create a copy of ColorPickerState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? colors = null,
    Object? pickedColor = freezed,
  }) {
    return _then(_ColorPickerState(
      colors: null == colors
          ? _self._colors
          : colors // ignore: cast_nullable_to_non_nullable
              as Map<String, Color>,
      pickedColor: freezed == pickedColor
          ? _self.pickedColor
          : pickedColor // ignore: cast_nullable_to_non_nullable
              as Color?,
    ));
  }
}

// dart format on
