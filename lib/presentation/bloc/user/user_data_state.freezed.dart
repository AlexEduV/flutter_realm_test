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

 bool get isLoading; bool get isLocationPermissionGranted; List<String> get favoriteIds; List<String> get createdIds; List<String> get viewedIds; bool get isUserAuthenticated; String get firstName; String get lastName; String get email; String get password; String get region; Map<DateTime, String>? get lastSeenCar; String? get avatarImageSrc;
/// Create a copy of UserDataState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserDataStateCopyWith<UserDataState> get copyWith => _$UserDataStateCopyWithImpl<UserDataState>(this as UserDataState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserDataState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isLocationPermissionGranted, isLocationPermissionGranted) || other.isLocationPermissionGranted == isLocationPermissionGranted)&&const DeepCollectionEquality().equals(other.favoriteIds, favoriteIds)&&const DeepCollectionEquality().equals(other.createdIds, createdIds)&&const DeepCollectionEquality().equals(other.viewedIds, viewedIds)&&(identical(other.isUserAuthenticated, isUserAuthenticated) || other.isUserAuthenticated == isUserAuthenticated)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.email, email) || other.email == email)&&(identical(other.password, password) || other.password == password)&&(identical(other.region, region) || other.region == region)&&const DeepCollectionEquality().equals(other.lastSeenCar, lastSeenCar)&&(identical(other.avatarImageSrc, avatarImageSrc) || other.avatarImageSrc == avatarImageSrc));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,isLocationPermissionGranted,const DeepCollectionEquality().hash(favoriteIds),const DeepCollectionEquality().hash(createdIds),const DeepCollectionEquality().hash(viewedIds),isUserAuthenticated,firstName,lastName,email,password,region,const DeepCollectionEquality().hash(lastSeenCar),avatarImageSrc);

@override
String toString() {
  return 'UserDataState(isLoading: $isLoading, isLocationPermissionGranted: $isLocationPermissionGranted, favoriteIds: $favoriteIds, createdIds: $createdIds, viewedIds: $viewedIds, isUserAuthenticated: $isUserAuthenticated, firstName: $firstName, lastName: $lastName, email: $email, password: $password, region: $region, lastSeenCar: $lastSeenCar, avatarImageSrc: $avatarImageSrc)';
}


}

/// @nodoc
abstract mixin class $UserDataStateCopyWith<$Res>  {
  factory $UserDataStateCopyWith(UserDataState value, $Res Function(UserDataState) _then) = _$UserDataStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, bool isLocationPermissionGranted, List<String> favoriteIds, List<String> createdIds, List<String> viewedIds, bool isUserAuthenticated, String firstName, String lastName, String email, String password, String region, Map<DateTime, String>? lastSeenCar, String? avatarImageSrc
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
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? isLocationPermissionGranted = null,Object? favoriteIds = null,Object? createdIds = null,Object? viewedIds = null,Object? isUserAuthenticated = null,Object? firstName = null,Object? lastName = null,Object? email = null,Object? password = null,Object? region = null,Object? lastSeenCar = freezed,Object? avatarImageSrc = freezed,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isLocationPermissionGranted: null == isLocationPermissionGranted ? _self.isLocationPermissionGranted : isLocationPermissionGranted // ignore: cast_nullable_to_non_nullable
as bool,favoriteIds: null == favoriteIds ? _self.favoriteIds : favoriteIds // ignore: cast_nullable_to_non_nullable
as List<String>,createdIds: null == createdIds ? _self.createdIds : createdIds // ignore: cast_nullable_to_non_nullable
as List<String>,viewedIds: null == viewedIds ? _self.viewedIds : viewedIds // ignore: cast_nullable_to_non_nullable
as List<String>,isUserAuthenticated: null == isUserAuthenticated ? _self.isUserAuthenticated : isUserAuthenticated // ignore: cast_nullable_to_non_nullable
as bool,firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,lastName: null == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,region: null == region ? _self.region : region // ignore: cast_nullable_to_non_nullable
as String,lastSeenCar: freezed == lastSeenCar ? _self.lastSeenCar : lastSeenCar // ignore: cast_nullable_to_non_nullable
as Map<DateTime, String>?,avatarImageSrc: freezed == avatarImageSrc ? _self.avatarImageSrc : avatarImageSrc // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// @nodoc


class _UserDataState implements UserDataState {
  const _UserDataState({this.isLoading = false, this.isLocationPermissionGranted = false, final  List<String> favoriteIds = const [], final  List<String> createdIds = const [], final  List<String> viewedIds = const [], this.isUserAuthenticated = false, this.firstName = '', this.lastName = '', this.email = '', this.password = '', this.region = '', final  Map<DateTime, String>? lastSeenCar = null, this.avatarImageSrc = null}): _favoriteIds = favoriteIds,_createdIds = createdIds,_viewedIds = viewedIds,_lastSeenCar = lastSeenCar;
  

@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  bool isLocationPermissionGranted;
 final  List<String> _favoriteIds;
@override@JsonKey() List<String> get favoriteIds {
  if (_favoriteIds is EqualUnmodifiableListView) return _favoriteIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_favoriteIds);
}

 final  List<String> _createdIds;
@override@JsonKey() List<String> get createdIds {
  if (_createdIds is EqualUnmodifiableListView) return _createdIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_createdIds);
}

 final  List<String> _viewedIds;
@override@JsonKey() List<String> get viewedIds {
  if (_viewedIds is EqualUnmodifiableListView) return _viewedIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_viewedIds);
}

@override@JsonKey() final  bool isUserAuthenticated;
@override@JsonKey() final  String firstName;
@override@JsonKey() final  String lastName;
@override@JsonKey() final  String email;
@override@JsonKey() final  String password;
@override@JsonKey() final  String region;
 final  Map<DateTime, String>? _lastSeenCar;
@override@JsonKey() Map<DateTime, String>? get lastSeenCar {
  final value = _lastSeenCar;
  if (value == null) return null;
  if (_lastSeenCar is EqualUnmodifiableMapView) return _lastSeenCar;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

@override@JsonKey() final  String? avatarImageSrc;

/// Create a copy of UserDataState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserDataStateCopyWith<_UserDataState> get copyWith => __$UserDataStateCopyWithImpl<_UserDataState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserDataState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isLocationPermissionGranted, isLocationPermissionGranted) || other.isLocationPermissionGranted == isLocationPermissionGranted)&&const DeepCollectionEquality().equals(other._favoriteIds, _favoriteIds)&&const DeepCollectionEquality().equals(other._createdIds, _createdIds)&&const DeepCollectionEquality().equals(other._viewedIds, _viewedIds)&&(identical(other.isUserAuthenticated, isUserAuthenticated) || other.isUserAuthenticated == isUserAuthenticated)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.email, email) || other.email == email)&&(identical(other.password, password) || other.password == password)&&(identical(other.region, region) || other.region == region)&&const DeepCollectionEquality().equals(other._lastSeenCar, _lastSeenCar)&&(identical(other.avatarImageSrc, avatarImageSrc) || other.avatarImageSrc == avatarImageSrc));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,isLocationPermissionGranted,const DeepCollectionEquality().hash(_favoriteIds),const DeepCollectionEquality().hash(_createdIds),const DeepCollectionEquality().hash(_viewedIds),isUserAuthenticated,firstName,lastName,email,password,region,const DeepCollectionEquality().hash(_lastSeenCar),avatarImageSrc);

@override
String toString() {
  return 'UserDataState(isLoading: $isLoading, isLocationPermissionGranted: $isLocationPermissionGranted, favoriteIds: $favoriteIds, createdIds: $createdIds, viewedIds: $viewedIds, isUserAuthenticated: $isUserAuthenticated, firstName: $firstName, lastName: $lastName, email: $email, password: $password, region: $region, lastSeenCar: $lastSeenCar, avatarImageSrc: $avatarImageSrc)';
}


}

/// @nodoc
abstract mixin class _$UserDataStateCopyWith<$Res> implements $UserDataStateCopyWith<$Res> {
  factory _$UserDataStateCopyWith(_UserDataState value, $Res Function(_UserDataState) _then) = __$UserDataStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, bool isLocationPermissionGranted, List<String> favoriteIds, List<String> createdIds, List<String> viewedIds, bool isUserAuthenticated, String firstName, String lastName, String email, String password, String region, Map<DateTime, String>? lastSeenCar, String? avatarImageSrc
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
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? isLocationPermissionGranted = null,Object? favoriteIds = null,Object? createdIds = null,Object? viewedIds = null,Object? isUserAuthenticated = null,Object? firstName = null,Object? lastName = null,Object? email = null,Object? password = null,Object? region = null,Object? lastSeenCar = freezed,Object? avatarImageSrc = freezed,}) {
  return _then(_UserDataState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isLocationPermissionGranted: null == isLocationPermissionGranted ? _self.isLocationPermissionGranted : isLocationPermissionGranted // ignore: cast_nullable_to_non_nullable
as bool,favoriteIds: null == favoriteIds ? _self._favoriteIds : favoriteIds // ignore: cast_nullable_to_non_nullable
as List<String>,createdIds: null == createdIds ? _self._createdIds : createdIds // ignore: cast_nullable_to_non_nullable
as List<String>,viewedIds: null == viewedIds ? _self._viewedIds : viewedIds // ignore: cast_nullable_to_non_nullable
as List<String>,isUserAuthenticated: null == isUserAuthenticated ? _self.isUserAuthenticated : isUserAuthenticated // ignore: cast_nullable_to_non_nullable
as bool,firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,lastName: null == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,region: null == region ? _self.region : region // ignore: cast_nullable_to_non_nullable
as String,lastSeenCar: freezed == lastSeenCar ? _self._lastSeenCar : lastSeenCar // ignore: cast_nullable_to_non_nullable
as Map<DateTime, String>?,avatarImageSrc: freezed == avatarImageSrc ? _self.avatarImageSrc : avatarImageSrc // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
