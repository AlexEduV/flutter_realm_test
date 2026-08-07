// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'location_settings_page_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LocationSettingsPageState {
  List<RegionUiModel> get availableRegions;
  RegionEntity? get currentRegion;

  /// Create a copy of LocationSettingsPageState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $LocationSettingsPageStateCopyWith<LocationSettingsPageState> get copyWith =>
      _$LocationSettingsPageStateCopyWithImpl<LocationSettingsPageState>(
          this as LocationSettingsPageState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is LocationSettingsPageState &&
            const DeepCollectionEquality()
                .equals(other.availableRegions, availableRegions) &&
            (identical(other.currentRegion, currentRegion) ||
                other.currentRegion == currentRegion));
  }

  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(availableRegions), currentRegion);

  @override
  String toString() {
    return 'LocationSettingsPageState(availableRegions: $availableRegions, currentRegion: $currentRegion)';
  }
}

/// @nodoc
abstract mixin class $LocationSettingsPageStateCopyWith<$Res> {
  factory $LocationSettingsPageStateCopyWith(LocationSettingsPageState value,
          $Res Function(LocationSettingsPageState) _then) =
      _$LocationSettingsPageStateCopyWithImpl;
  @useResult
  $Res call(
      {List<RegionUiModel> availableRegions, RegionEntity? currentRegion});
}

/// @nodoc
class _$LocationSettingsPageStateCopyWithImpl<$Res>
    implements $LocationSettingsPageStateCopyWith<$Res> {
  _$LocationSettingsPageStateCopyWithImpl(this._self, this._then);

  final LocationSettingsPageState _self;
  final $Res Function(LocationSettingsPageState) _then;

  /// Create a copy of LocationSettingsPageState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? availableRegions = null,
    Object? currentRegion = freezed,
  }) {
    return _then(_self.copyWith(
      availableRegions: null == availableRegions
          ? _self.availableRegions
          : availableRegions // ignore: cast_nullable_to_non_nullable
              as List<RegionUiModel>,
      currentRegion: freezed == currentRegion
          ? _self.currentRegion
          : currentRegion // ignore: cast_nullable_to_non_nullable
              as RegionEntity?,
    ));
  }
}

/// @nodoc

class _LocationSettingsPageState implements LocationSettingsPageState {
  const _LocationSettingsPageState(
      {final List<RegionUiModel> availableRegions = const [],
      this.currentRegion})
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

  @override
  final RegionEntity? currentRegion;

  /// Create a copy of LocationSettingsPageState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$LocationSettingsPageStateCopyWith<_LocationSettingsPageState>
      get copyWith =>
          __$LocationSettingsPageStateCopyWithImpl<_LocationSettingsPageState>(
              this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _LocationSettingsPageState &&
            const DeepCollectionEquality()
                .equals(other._availableRegions, _availableRegions) &&
            (identical(other.currentRegion, currentRegion) ||
                other.currentRegion == currentRegion));
  }

  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_availableRegions), currentRegion);

  @override
  String toString() {
    return 'LocationSettingsPageState(availableRegions: $availableRegions, currentRegion: $currentRegion)';
  }
}

/// @nodoc
abstract mixin class _$LocationSettingsPageStateCopyWith<$Res>
    implements $LocationSettingsPageStateCopyWith<$Res> {
  factory _$LocationSettingsPageStateCopyWith(_LocationSettingsPageState value,
          $Res Function(_LocationSettingsPageState) _then) =
      __$LocationSettingsPageStateCopyWithImpl;
  @override
  @useResult
  $Res call(
      {List<RegionUiModel> availableRegions, RegionEntity? currentRegion});
}

/// @nodoc
class __$LocationSettingsPageStateCopyWithImpl<$Res>
    implements _$LocationSettingsPageStateCopyWith<$Res> {
  __$LocationSettingsPageStateCopyWithImpl(this._self, this._then);

  final _LocationSettingsPageState _self;
  final $Res Function(_LocationSettingsPageState) _then;

  /// Create a copy of LocationSettingsPageState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? availableRegions = null,
    Object? currentRegion = freezed,
  }) {
    return _then(_LocationSettingsPageState(
      availableRegions: null == availableRegions
          ? _self._availableRegions
          : availableRegions // ignore: cast_nullable_to_non_nullable
              as List<RegionUiModel>,
      currentRegion: freezed == currentRegion
          ? _self.currentRegion
          : currentRegion // ignore: cast_nullable_to_non_nullable
              as RegionEntity?,
    ));
  }
}

// dart format on
