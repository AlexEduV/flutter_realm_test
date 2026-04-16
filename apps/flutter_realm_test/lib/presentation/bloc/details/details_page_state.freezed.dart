// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'details_page_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DetailsPageState {
  bool get isLoading;
  bool get isVehicleSpecsExpanded;
  CarEntity? get car;
  Color? get carColor;

  /// Create a copy of DetailsPageState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $DetailsPageStateCopyWith<DetailsPageState> get copyWith =>
      _$DetailsPageStateCopyWithImpl<DetailsPageState>(
          this as DetailsPageState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is DetailsPageState &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.isVehicleSpecsExpanded, isVehicleSpecsExpanded) ||
                other.isVehicleSpecsExpanded == isVehicleSpecsExpanded) &&
            (identical(other.car, car) || other.car == car) &&
            (identical(other.carColor, carColor) ||
                other.carColor == carColor));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, isLoading, isVehicleSpecsExpanded, car, carColor);

  @override
  String toString() {
    return 'DetailsPageState(isLoading: $isLoading, isVehicleSpecsExpanded: $isVehicleSpecsExpanded, car: $car, carColor: $carColor)';
  }
}

/// @nodoc
abstract mixin class $DetailsPageStateCopyWith<$Res> {
  factory $DetailsPageStateCopyWith(
          DetailsPageState value, $Res Function(DetailsPageState) _then) =
      _$DetailsPageStateCopyWithImpl;
  @useResult
  $Res call(
      {bool isLoading,
      bool isVehicleSpecsExpanded,
      CarEntity? car,
      Color? carColor});
}

/// @nodoc
class _$DetailsPageStateCopyWithImpl<$Res>
    implements $DetailsPageStateCopyWith<$Res> {
  _$DetailsPageStateCopyWithImpl(this._self, this._then);

  final DetailsPageState _self;
  final $Res Function(DetailsPageState) _then;

  /// Create a copy of DetailsPageState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? isVehicleSpecsExpanded = null,
    Object? car = freezed,
    Object? carColor = freezed,
  }) {
    return _then(_self.copyWith(
      isLoading: null == isLoading
          ? _self.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isVehicleSpecsExpanded: null == isVehicleSpecsExpanded
          ? _self.isVehicleSpecsExpanded
          : isVehicleSpecsExpanded // ignore: cast_nullable_to_non_nullable
              as bool,
      car: freezed == car
          ? _self.car
          : car // ignore: cast_nullable_to_non_nullable
              as CarEntity?,
      carColor: freezed == carColor
          ? _self.carColor
          : carColor // ignore: cast_nullable_to_non_nullable
              as Color?,
    ));
  }
}

/// @nodoc

class _DetailsPageState implements DetailsPageState {
  const _DetailsPageState(
      {this.isLoading = false,
      this.isVehicleSpecsExpanded = true,
      this.car,
      this.carColor});

  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final bool isVehicleSpecsExpanded;
  @override
  final CarEntity? car;
  @override
  final Color? carColor;

  /// Create a copy of DetailsPageState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$DetailsPageStateCopyWith<_DetailsPageState> get copyWith =>
      __$DetailsPageStateCopyWithImpl<_DetailsPageState>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _DetailsPageState &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.isVehicleSpecsExpanded, isVehicleSpecsExpanded) ||
                other.isVehicleSpecsExpanded == isVehicleSpecsExpanded) &&
            (identical(other.car, car) || other.car == car) &&
            (identical(other.carColor, carColor) ||
                other.carColor == carColor));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, isLoading, isVehicleSpecsExpanded, car, carColor);

  @override
  String toString() {
    return 'DetailsPageState(isLoading: $isLoading, isVehicleSpecsExpanded: $isVehicleSpecsExpanded, car: $car, carColor: $carColor)';
  }
}

/// @nodoc
abstract mixin class _$DetailsPageStateCopyWith<$Res>
    implements $DetailsPageStateCopyWith<$Res> {
  factory _$DetailsPageStateCopyWith(
          _DetailsPageState value, $Res Function(_DetailsPageState) _then) =
      __$DetailsPageStateCopyWithImpl;
  @override
  @useResult
  $Res call(
      {bool isLoading,
      bool isVehicleSpecsExpanded,
      CarEntity? car,
      Color? carColor});
}

/// @nodoc
class __$DetailsPageStateCopyWithImpl<$Res>
    implements _$DetailsPageStateCopyWith<$Res> {
  __$DetailsPageStateCopyWithImpl(this._self, this._then);

  final _DetailsPageState _self;
  final $Res Function(_DetailsPageState) _then;

  /// Create a copy of DetailsPageState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? isLoading = null,
    Object? isVehicleSpecsExpanded = null,
    Object? car = freezed,
    Object? carColor = freezed,
  }) {
    return _then(_DetailsPageState(
      isLoading: null == isLoading
          ? _self.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isVehicleSpecsExpanded: null == isVehicleSpecsExpanded
          ? _self.isVehicleSpecsExpanded
          : isVehicleSpecsExpanded // ignore: cast_nullable_to_non_nullable
              as bool,
      car: freezed == car
          ? _self.car
          : car // ignore: cast_nullable_to_non_nullable
              as CarEntity?,
      carColor: freezed == carColor
          ? _self.carColor
          : carColor // ignore: cast_nullable_to_non_nullable
              as Color?,
    ));
  }
}

// dart format on
