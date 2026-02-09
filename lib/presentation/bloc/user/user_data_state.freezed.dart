// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_data_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$UserDataState {

 bool get isLocationPermissionGranted; List<String> get favoriteIds;
/// Create a copy of UserDataState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserDataStateCopyWith<UserDataState> get copyWith => _$UserDataStateCopyWithImpl<UserDataState>(this as UserDataState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserDataState&&(identical(other.isLocationPermissionGranted, isLocationPermissionGranted) || other.isLocationPermissionGranted == isLocationPermissionGranted)&&const DeepCollectionEquality().equals(other.favoriteIds, favoriteIds));
}


@override
int get hashCode => Object.hash(runtimeType,isLocationPermissionGranted,const DeepCollectionEquality().hash(favoriteIds));

@override
String toString() {
  return 'UserDataState(isLocationPermissionGranted: $isLocationPermissionGranted, favoriteIds: $favoriteIds)';
}


}

/// @nodoc
abstract mixin class $UserDataStateCopyWith<$Res>  {
  factory $UserDataStateCopyWith(UserDataState value, $Res Function(UserDataState) _then) = _$UserDataStateCopyWithImpl;
@useResult
$Res call({
 bool isLocationPermissionGranted, List<String> favoriteIds
});




}
/// @nodoc
class _$UserDataStateCopyWithImpl<$Res>
    implements $UserDataStateCopyWith<$Res> {
  _$UserDataStateCopyWithImpl(this._self, this._then);

  final UserDataState _self;
  final $Res Function(UserDataState) _then;

/// Create a copy of UserDataState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLocationPermissionGranted = null,Object? favoriteIds = null,}) {
  return _then(_self.copyWith(
isLocationPermissionGranted: null == isLocationPermissionGranted ? _self.isLocationPermissionGranted : isLocationPermissionGranted // ignore: cast_nullable_to_non_nullable
as bool,favoriteIds: null == favoriteIds ? _self.favoriteIds : favoriteIds // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// @nodoc


class _UserDataState implements UserDataState {
  const _UserDataState({this.isLocationPermissionGranted = false, final  List<String> favoriteIds = const []}): _favoriteIds = favoriteIds;
  

@override@JsonKey() final  bool isLocationPermissionGranted;
 final  List<String> _favoriteIds;
@override@JsonKey() List<String> get favoriteIds {
  if (_favoriteIds is EqualUnmodifiableListView) return _favoriteIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_favoriteIds);
}


/// Create a copy of UserDataState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserDataStateCopyWith<_UserDataState> get copyWith => __$UserDataStateCopyWithImpl<_UserDataState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserDataState&&(identical(other.isLocationPermissionGranted, isLocationPermissionGranted) || other.isLocationPermissionGranted == isLocationPermissionGranted)&&const DeepCollectionEquality().equals(other._favoriteIds, _favoriteIds));
}


@override
int get hashCode => Object.hash(runtimeType,isLocationPermissionGranted,const DeepCollectionEquality().hash(_favoriteIds));

@override
String toString() {
  return 'UserDataState(isLocationPermissionGranted: $isLocationPermissionGranted, favoriteIds: $favoriteIds)';
}


}

/// @nodoc
abstract mixin class _$UserDataStateCopyWith<$Res> implements $UserDataStateCopyWith<$Res> {
  factory _$UserDataStateCopyWith(_UserDataState value, $Res Function(_UserDataState) _then) = __$UserDataStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLocationPermissionGranted, List<String> favoriteIds
});




}
/// @nodoc
class __$UserDataStateCopyWithImpl<$Res>
    implements _$UserDataStateCopyWith<$Res> {
  __$UserDataStateCopyWithImpl(this._self, this._then);

  final _UserDataState _self;
  final $Res Function(_UserDataState) _then;

/// Create a copy of UserDataState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLocationPermissionGranted = null,Object? favoriteIds = null,}) {
  return _then(_UserDataState(
isLocationPermissionGranted: null == isLocationPermissionGranted ? _self.isLocationPermissionGranted : isLocationPermissionGranted // ignore: cast_nullable_to_non_nullable
as bool,favoriteIds: null == favoriteIds ? _self._favoriteIds : favoriteIds // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on
