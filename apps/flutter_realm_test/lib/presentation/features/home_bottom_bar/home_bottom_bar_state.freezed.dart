// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_bottom_bar_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$HomeBottomBarState {
  int get currentSelectedTabIndex;

  /// Create a copy of HomeBottomBarState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $HomeBottomBarStateCopyWith<HomeBottomBarState> get copyWith =>
      _$HomeBottomBarStateCopyWithImpl<HomeBottomBarState>(
          this as HomeBottomBarState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is HomeBottomBarState &&
            (identical(
                    other.currentSelectedTabIndex, currentSelectedTabIndex) ||
                other.currentSelectedTabIndex == currentSelectedTabIndex));
  }

  @override
  int get hashCode => Object.hash(runtimeType, currentSelectedTabIndex);

  @override
  String toString() {
    return 'HomeBottomBarState(currentSelectedTabIndex: $currentSelectedTabIndex)';
  }
}

/// @nodoc
abstract mixin class $HomeBottomBarStateCopyWith<$Res> {
  factory $HomeBottomBarStateCopyWith(
          HomeBottomBarState value, $Res Function(HomeBottomBarState) _then) =
      _$HomeBottomBarStateCopyWithImpl;
  @useResult
  $Res call({int currentSelectedTabIndex});
}

/// @nodoc
class _$HomeBottomBarStateCopyWithImpl<$Res>
    implements $HomeBottomBarStateCopyWith<$Res> {
  _$HomeBottomBarStateCopyWithImpl(this._self, this._then);

  final HomeBottomBarState _self;
  final $Res Function(HomeBottomBarState) _then;

  /// Create a copy of HomeBottomBarState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentSelectedTabIndex = null,
  }) {
    return _then(_self.copyWith(
      currentSelectedTabIndex: null == currentSelectedTabIndex
          ? _self.currentSelectedTabIndex
          : currentSelectedTabIndex // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _HomeBottomBarState implements HomeBottomBarState {
  const _HomeBottomBarState({this.currentSelectedTabIndex = 0});

  @override
  @JsonKey()
  final int currentSelectedTabIndex;

  /// Create a copy of HomeBottomBarState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$HomeBottomBarStateCopyWith<_HomeBottomBarState> get copyWith =>
      __$HomeBottomBarStateCopyWithImpl<_HomeBottomBarState>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _HomeBottomBarState &&
            (identical(
                    other.currentSelectedTabIndex, currentSelectedTabIndex) ||
                other.currentSelectedTabIndex == currentSelectedTabIndex));
  }

  @override
  int get hashCode => Object.hash(runtimeType, currentSelectedTabIndex);

  @override
  String toString() {
    return 'HomeBottomBarState(currentSelectedTabIndex: $currentSelectedTabIndex)';
  }
}

/// @nodoc
abstract mixin class _$HomeBottomBarStateCopyWith<$Res>
    implements $HomeBottomBarStateCopyWith<$Res> {
  factory _$HomeBottomBarStateCopyWith(
          _HomeBottomBarState value, $Res Function(_HomeBottomBarState) _then) =
      __$HomeBottomBarStateCopyWithImpl;
  @override
  @useResult
  $Res call({int currentSelectedTabIndex});
}

/// @nodoc
class __$HomeBottomBarStateCopyWithImpl<$Res>
    implements _$HomeBottomBarStateCopyWith<$Res> {
  __$HomeBottomBarStateCopyWithImpl(this._self, this._then);

  final _HomeBottomBarState _self;
  final $Res Function(_HomeBottomBarState) _then;

  /// Create a copy of HomeBottomBarState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? currentSelectedTabIndex = null,
  }) {
    return _then(_HomeBottomBarState(
      currentSelectedTabIndex: null == currentSelectedTabIndex
          ? _self.currentSelectedTabIndex
          : currentSelectedTabIndex // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

// dart format on
