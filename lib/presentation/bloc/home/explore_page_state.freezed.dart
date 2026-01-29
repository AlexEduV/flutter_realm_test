// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'explore_page_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ExplorePageState {

 List<CarEntity> get cars; bool get isLoading;
/// Create a copy of ExplorePageState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExplorePageStateCopyWith<ExplorePageState> get copyWith => _$ExplorePageStateCopyWithImpl<ExplorePageState>(this as ExplorePageState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExplorePageState&&const DeepCollectionEquality().equals(other.cars, cars)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(cars),isLoading);

@override
String toString() {
  return 'ExplorePageState(cars: $cars, isLoading: $isLoading)';
}


}

/// @nodoc
abstract mixin class $ExplorePageStateCopyWith<$Res>  {
  factory $ExplorePageStateCopyWith(ExplorePageState value, $Res Function(ExplorePageState) _then) = _$ExplorePageStateCopyWithImpl;
@useResult
$Res call({
 List<CarEntity> cars, bool isLoading
});




}
/// @nodoc
class _$ExplorePageStateCopyWithImpl<$Res>
    implements $ExplorePageStateCopyWith<$Res> {
  _$ExplorePageStateCopyWithImpl(this._self, this._then);

  final ExplorePageState _self;
  final $Res Function(ExplorePageState) _then;

/// Create a copy of ExplorePageState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? cars = null,Object? isLoading = null,}) {
  return _then(_self.copyWith(
cars: null == cars ? _self.cars : cars // ignore: cast_nullable_to_non_nullable
as List<CarEntity>,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// @nodoc


class _ExplorePageState implements ExplorePageState {
  const _ExplorePageState({final  List<CarEntity> cars = const [], this.isLoading = false}): _cars = cars;
  

 final  List<CarEntity> _cars;
@override@JsonKey() List<CarEntity> get cars {
  if (_cars is EqualUnmodifiableListView) return _cars;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_cars);
}

@override@JsonKey() final  bool isLoading;

/// Create a copy of ExplorePageState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ExplorePageStateCopyWith<_ExplorePageState> get copyWith => __$ExplorePageStateCopyWithImpl<_ExplorePageState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ExplorePageState&&const DeepCollectionEquality().equals(other._cars, _cars)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_cars),isLoading);

@override
String toString() {
  return 'ExplorePageState(cars: $cars, isLoading: $isLoading)';
}


}

/// @nodoc
abstract mixin class _$ExplorePageStateCopyWith<$Res> implements $ExplorePageStateCopyWith<$Res> {
  factory _$ExplorePageStateCopyWith(_ExplorePageState value, $Res Function(_ExplorePageState) _then) = __$ExplorePageStateCopyWithImpl;
@override @useResult
$Res call({
 List<CarEntity> cars, bool isLoading
});




}
/// @nodoc
class __$ExplorePageStateCopyWithImpl<$Res>
    implements _$ExplorePageStateCopyWith<$Res> {
  __$ExplorePageStateCopyWithImpl(this._self, this._then);

  final _ExplorePageState _self;
  final $Res Function(_ExplorePageState) _then;

/// Create a copy of ExplorePageState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? cars = null,Object? isLoading = null,}) {
  return _then(_ExplorePageState(
cars: null == cars ? _self._cars : cars // ignore: cast_nullable_to_non_nullable
as List<CarEntity>,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
