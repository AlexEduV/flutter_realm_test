// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'last_seen_car_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LastSeenCarEntity {
  String get carId;
  DateTime get seenAt;

  /// Create a copy of LastSeenCarEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $LastSeenCarEntityCopyWith<LastSeenCarEntity> get copyWith =>
      _$LastSeenCarEntityCopyWithImpl<LastSeenCarEntity>(
          this as LastSeenCarEntity, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is LastSeenCarEntity &&
            (identical(other.carId, carId) || other.carId == carId) &&
            (identical(other.seenAt, seenAt) || other.seenAt == seenAt));
  }

  @override
  int get hashCode => Object.hash(runtimeType, carId, seenAt);

  @override
  String toString() {
    return 'LastSeenCarEntity(carId: $carId, seenAt: $seenAt)';
  }
}

/// @nodoc
abstract mixin class $LastSeenCarEntityCopyWith<$Res> {
  factory $LastSeenCarEntityCopyWith(
          LastSeenCarEntity value, $Res Function(LastSeenCarEntity) _then) =
      _$LastSeenCarEntityCopyWithImpl;
  @useResult
  $Res call({String carId, DateTime seenAt});
}

/// @nodoc
class _$LastSeenCarEntityCopyWithImpl<$Res>
    implements $LastSeenCarEntityCopyWith<$Res> {
  _$LastSeenCarEntityCopyWithImpl(this._self, this._then);

  final LastSeenCarEntity _self;
  final $Res Function(LastSeenCarEntity) _then;

  /// Create a copy of LastSeenCarEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? carId = null,
    Object? seenAt = null,
  }) {
    return _then(_self.copyWith(
      carId: null == carId
          ? _self.carId
          : carId // ignore: cast_nullable_to_non_nullable
              as String,
      seenAt: null == seenAt
          ? _self.seenAt
          : seenAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc

class _LastSeenCarEntity implements LastSeenCarEntity {
  const _LastSeenCarEntity({required this.carId, required this.seenAt});

  @override
  final String carId;
  @override
  final DateTime seenAt;

  /// Create a copy of LastSeenCarEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$LastSeenCarEntityCopyWith<_LastSeenCarEntity> get copyWith =>
      __$LastSeenCarEntityCopyWithImpl<_LastSeenCarEntity>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _LastSeenCarEntity &&
            (identical(other.carId, carId) || other.carId == carId) &&
            (identical(other.seenAt, seenAt) || other.seenAt == seenAt));
  }

  @override
  int get hashCode => Object.hash(runtimeType, carId, seenAt);

  @override
  String toString() {
    return 'LastSeenCarEntity(carId: $carId, seenAt: $seenAt)';
  }
}

/// @nodoc
abstract mixin class _$LastSeenCarEntityCopyWith<$Res>
    implements $LastSeenCarEntityCopyWith<$Res> {
  factory _$LastSeenCarEntityCopyWith(
          _LastSeenCarEntity value, $Res Function(_LastSeenCarEntity) _then) =
      __$LastSeenCarEntityCopyWithImpl;
  @override
  @useResult
  $Res call({String carId, DateTime seenAt});
}

/// @nodoc
class __$LastSeenCarEntityCopyWithImpl<$Res>
    implements _$LastSeenCarEntityCopyWith<$Res> {
  __$LastSeenCarEntityCopyWithImpl(this._self, this._then);

  final _LastSeenCarEntity _self;
  final $Res Function(_LastSeenCarEntity) _then;

  /// Create a copy of LastSeenCarEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? carId = null,
    Object? seenAt = null,
  }) {
    return _then(_LastSeenCarEntity(
      carId: null == carId
          ? _self.carId
          : carId // ignore: cast_nullable_to_non_nullable
              as String,
      seenAt: null == seenAt
          ? _self.seenAt
          : seenAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

// dart format on
