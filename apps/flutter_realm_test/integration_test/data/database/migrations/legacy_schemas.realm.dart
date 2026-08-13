// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'legacy_schemas.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
class LegacyUserV26 extends _LegacyUserV26
    with RealmEntity, RealmObjectBase, RealmObject {
  LegacyUserV26(
    String userId,
    String name,
  ) {
    RealmObjectBase.set(this, 'userId', userId);
    RealmObjectBase.set(this, 'name', name);
  }

  LegacyUserV26._();

  @override
  String get userId => RealmObjectBase.get<String>(this, 'userId') as String;
  @override
  set userId(String value) => RealmObjectBase.set(this, 'userId', value);

  @override
  String get name => RealmObjectBase.get<String>(this, 'name') as String;
  @override
  set name(String value) => RealmObjectBase.set(this, 'name', value);

  @override
  Stream<RealmObjectChanges<LegacyUserV26>> get changes =>
      RealmObjectBase.getChanges<LegacyUserV26>(this);

  @override
  Stream<RealmObjectChanges<LegacyUserV26>> changesFor(
          [List<String>? keyPaths]) =>
      RealmObjectBase.getChangesFor<LegacyUserV26>(this, keyPaths);

  @override
  LegacyUserV26 freeze() => RealmObjectBase.freezeObject<LegacyUserV26>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'userId': userId.toEJson(),
      'name': name.toEJson(),
    };
  }

  static EJsonValue _toEJson(LegacyUserV26 value) => value.toEJson();
  static LegacyUserV26 _fromEJson(EJsonValue ejson) {
    if (ejson is! Map<String, dynamic>) return raiseInvalidEJson(ejson);
    return switch (ejson) {
      {
        'userId': EJsonValue userId,
        'name': EJsonValue name,
      } =>
        LegacyUserV26(
          fromEJson(userId),
          fromEJson(name),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(LegacyUserV26._);
    register(_toEJson, _fromEJson);
    return const SchemaObject(ObjectType.realmObject, LegacyUserV26, 'User', [
      SchemaProperty('userId', RealmPropertyType.string, primaryKey: true),
      SchemaProperty('name', RealmPropertyType.string),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}

class LegacyCarV27 extends _LegacyCarV27
    with RealmEntity, RealmObjectBase, RealmObject {
  LegacyCarV27(
    ObjectId id,
    String carId,
    String manufacturer,
    String type, {
    int? kilometers,
  }) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'carId', carId);
    RealmObjectBase.set(this, 'manufacturer', manufacturer);
    RealmObjectBase.set(this, 'type', type);
    RealmObjectBase.set(this, 'kilometers', kilometers);
  }

  LegacyCarV27._();

  @override
  ObjectId get id => RealmObjectBase.get<ObjectId>(this, 'id') as ObjectId;
  @override
  set id(ObjectId value) => RealmObjectBase.set(this, 'id', value);

  @override
  String get carId => RealmObjectBase.get<String>(this, 'carId') as String;
  @override
  set carId(String value) => RealmObjectBase.set(this, 'carId', value);

  @override
  String get manufacturer =>
      RealmObjectBase.get<String>(this, 'manufacturer') as String;
  @override
  set manufacturer(String value) =>
      RealmObjectBase.set(this, 'manufacturer', value);

  @override
  String get type => RealmObjectBase.get<String>(this, 'type') as String;
  @override
  set type(String value) => RealmObjectBase.set(this, 'type', value);

  @override
  int? get kilometers => RealmObjectBase.get<int>(this, 'kilometers') as int?;
  @override
  set kilometers(int? value) => RealmObjectBase.set(this, 'kilometers', value);

  @override
  Stream<RealmObjectChanges<LegacyCarV27>> get changes =>
      RealmObjectBase.getChanges<LegacyCarV27>(this);

  @override
  Stream<RealmObjectChanges<LegacyCarV27>> changesFor(
          [List<String>? keyPaths]) =>
      RealmObjectBase.getChangesFor<LegacyCarV27>(this, keyPaths);

  @override
  LegacyCarV27 freeze() => RealmObjectBase.freezeObject<LegacyCarV27>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'id': id.toEJson(),
      'carId': carId.toEJson(),
      'manufacturer': manufacturer.toEJson(),
      'type': type.toEJson(),
      'kilometers': kilometers.toEJson(),
    };
  }

  static EJsonValue _toEJson(LegacyCarV27 value) => value.toEJson();
  static LegacyCarV27 _fromEJson(EJsonValue ejson) {
    if (ejson is! Map<String, dynamic>) return raiseInvalidEJson(ejson);
    return switch (ejson) {
      {
        'id': EJsonValue id,
        'carId': EJsonValue carId,
        'manufacturer': EJsonValue manufacturer,
        'type': EJsonValue type,
      } =>
        LegacyCarV27(
          fromEJson(id),
          fromEJson(carId),
          fromEJson(manufacturer),
          fromEJson(type),
          kilometers: fromEJson(ejson['kilometers']),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(LegacyCarV27._);
    register(_toEJson, _fromEJson);
    return const SchemaObject(ObjectType.realmObject, LegacyCarV27, 'Car', [
      SchemaProperty('id', RealmPropertyType.objectid, primaryKey: true),
      SchemaProperty('carId', RealmPropertyType.string),
      SchemaProperty('manufacturer', RealmPropertyType.string),
      SchemaProperty('type', RealmPropertyType.string),
      SchemaProperty('kilometers', RealmPropertyType.int, optional: true),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}

class LegacyCarV28 extends _LegacyCarV28
    with RealmEntity, RealmObjectBase, RealmObject {
  LegacyCarV28(
    ObjectId id,
    String carId,
    String manufacturer,
    String type, {
    String? fuelType,
  }) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'carId', carId);
    RealmObjectBase.set(this, 'manufacturer', manufacturer);
    RealmObjectBase.set(this, 'type', type);
    RealmObjectBase.set(this, 'fuelType', fuelType);
  }

  LegacyCarV28._();

  @override
  ObjectId get id => RealmObjectBase.get<ObjectId>(this, 'id') as ObjectId;
  @override
  set id(ObjectId value) => RealmObjectBase.set(this, 'id', value);

  @override
  String get carId => RealmObjectBase.get<String>(this, 'carId') as String;
  @override
  set carId(String value) => RealmObjectBase.set(this, 'carId', value);

  @override
  String get manufacturer =>
      RealmObjectBase.get<String>(this, 'manufacturer') as String;
  @override
  set manufacturer(String value) =>
      RealmObjectBase.set(this, 'manufacturer', value);

  @override
  String get type => RealmObjectBase.get<String>(this, 'type') as String;
  @override
  set type(String value) => RealmObjectBase.set(this, 'type', value);

  @override
  String? get fuelType =>
      RealmObjectBase.get<String>(this, 'fuelType') as String?;
  @override
  set fuelType(String? value) => RealmObjectBase.set(this, 'fuelType', value);

  @override
  Stream<RealmObjectChanges<LegacyCarV28>> get changes =>
      RealmObjectBase.getChanges<LegacyCarV28>(this);

  @override
  Stream<RealmObjectChanges<LegacyCarV28>> changesFor(
          [List<String>? keyPaths]) =>
      RealmObjectBase.getChangesFor<LegacyCarV28>(this, keyPaths);

  @override
  LegacyCarV28 freeze() => RealmObjectBase.freezeObject<LegacyCarV28>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'id': id.toEJson(),
      'carId': carId.toEJson(),
      'manufacturer': manufacturer.toEJson(),
      'type': type.toEJson(),
      'fuelType': fuelType.toEJson(),
    };
  }

  static EJsonValue _toEJson(LegacyCarV28 value) => value.toEJson();
  static LegacyCarV28 _fromEJson(EJsonValue ejson) {
    if (ejson is! Map<String, dynamic>) return raiseInvalidEJson(ejson);
    return switch (ejson) {
      {
        'id': EJsonValue id,
        'carId': EJsonValue carId,
        'manufacturer': EJsonValue manufacturer,
        'type': EJsonValue type,
      } =>
        LegacyCarV28(
          fromEJson(id),
          fromEJson(carId),
          fromEJson(manufacturer),
          fromEJson(type),
          fuelType: fromEJson(ejson['fuelType']),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(LegacyCarV28._);
    register(_toEJson, _fromEJson);
    return const SchemaObject(ObjectType.realmObject, LegacyCarV28, 'Car', [
      SchemaProperty('id', RealmPropertyType.objectid, primaryKey: true),
      SchemaProperty('carId', RealmPropertyType.string),
      SchemaProperty('manufacturer', RealmPropertyType.string),
      SchemaProperty('type', RealmPropertyType.string),
      SchemaProperty('fuelType', RealmPropertyType.string, optional: true),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}
