// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'location_settings_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LocationSettingsState {
  List<RegionUiModel> get availableRegions;

  /// Create a copy of LocationSettingsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $LocationSettingsStateCopyWith<LocationSettingsState> get copyWith =>
      _$LocationSettingsStateCopyWithImpl<LocationSettingsState>(
          this as LocationSettingsState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is LocationSettingsState &&
            const DeepCollectionEquality()
                .equals(other.availableRegions, availableRegions));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(availableRegions));

  @override
  String toString() {
    return 'LocationSettingsState(availableRegions: $availableRegions)';
  }
}

/// @nodoc
abstract mixin class $LocationSettingsStateCopyWith<$Res> {
  factory $LocationSettingsStateCopyWith(LocationSettingsState value,
          $Res Function(LocationSettingsState) _then) =
      _$LocationSettingsStateCopyWithImpl;
  @useResult
  $Res call({List<RegionUiModel> availableRegions});
}

/// @nodoc
class _$LocationSettingsStateCopyWithImpl<$Res>
    implements $LocationSettingsStateCopyWith<$Res> {
  _$LocationSettingsStateCopyWithImpl(this._self, this._then);

  final LocationSettingsState _self;
  final $Res Function(LocationSettingsState) _then;

  /// Create a copy of LocationSettingsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? availableRegions = null,
  }) {
    return _then(_self.copyWith(
      availableRegions: null == availableRegions
          ? _self.availableRegions
          : availableRegions // ignore: cast_nullable_to_non_nullable
              as List<RegionUiModel>,
    ));
  }
}

/// @nodoc

class _LocationSettingsState implements LocationSettingsState {
  const _LocationSettingsState(
      {final List<RegionUiModel> availableRegions = const []})
      : _availableRegions = availableRegions;

  final List<RegionUiModel> _availableRegions;
  @override
  @JsonKey()
  List<RegionUiModel> get availableRegions {
    if (_availableRegions is EqualUnmodifiableListView)
      return _availableRegions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_availableRegions);
  }

  /// Create a copy of LocationSettingsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$LocationSettingsStateCopyWith<_LocationSettingsState> get copyWith =>
      __$LocationSettingsStateCopyWithImpl<_LocationSettingsState>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _LocationSettingsState &&
            const DeepCollectionEquality()
                .equals(other._availableRegions, _availableRegions));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_availableRegions));

  @override
  String toString() {
    return 'LocationSettingsState(availableRegions: $availableRegions)';
  }
}

/// @nodoc
abstract mixin class _$LocationSettingsStateCopyWith<$Res>
    implements $LocationSettingsStateCopyWith<$Res> {
  factory _$LocationSettingsStateCopyWith(_LocationSettingsState value,
          $Res Function(_LocationSettingsState) _then) =
      __$LocationSettingsStateCopyWithImpl;
  @override
  @useResult
  $Res call({List<RegionUiModel> availableRegions});
}

/// @nodoc
class __$LocationSettingsStateCopyWithImpl<$Res>
    implements _$LocationSettingsStateCopyWith<$Res> {
  __$LocationSettingsStateCopyWithImpl(this._self, this._then);

  final _LocationSettingsState _self;
  final $Res Function(_LocationSettingsState) _then;

  /// Create a copy of LocationSettingsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? availableRegions = null,
  }) {
    return _then(_LocationSettingsState(
      availableRegions: null == availableRegions
          ? _self._availableRegions
          : availableRegions // ignore: cast_nullable_to_non_nullable
              as List<RegionUiModel>,
    ));
  }
}

// dart format on
