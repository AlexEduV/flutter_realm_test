// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scheme.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
class Car extends _Car with RealmEntity, RealmObjectBase, RealmObject {
  static var _defaultsSet = false;

  Car(
    ObjectId id,
    String manufacturer, {
    String? model,
    String? year,
    bool? isChecked = false,
    bool? isHotProposition = false,
    int? kilometers = 500,
    int? distanceTo,
    int price = 0,
    Person? owner,
  }) {
    if (!_defaultsSet) {
      _defaultsSet = RealmObjectBase.setDefaults<Car>({
        'isChecked': false,
        'isHotProposition': false,
        'kilometers': 500,
        'price': 0,
      });
    }
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'manufacturer', manufacturer);
    RealmObjectBase.set(this, 'model', model);
    RealmObjectBase.set(this, 'year', year);
    RealmObjectBase.set(this, 'isChecked', isChecked);
    RealmObjectBase.set(this, 'isHotProposition', isHotProposition);
    RealmObjectBase.set(this, 'kilometers', kilometers);
    RealmObjectBase.set(this, 'distanceTo', distanceTo);
    RealmObjectBase.set(this, 'price', price);
    RealmObjectBase.set(this, 'owner', owner);
  }

  Car._();

  @override
  ObjectId get id => RealmObjectBase.get<ObjectId>(this, 'id') as ObjectId;
  @override
  set id(ObjectId value) => RealmObjectBase.set(this, 'id', value);

  @override
  String get manufacturer =>
      RealmObjectBase.get<String>(this, 'manufacturer') as String;
  @override
  set manufacturer(String value) =>
      RealmObjectBase.set(this, 'manufacturer', value);

  @override
  String? get model => RealmObjectBase.get<String>(this, 'model') as String?;
  @override
  set model(String? value) => RealmObjectBase.set(this, 'model', value);

  @override
  String? get year => RealmObjectBase.get<String>(this, 'year') as String?;
  @override
  set year(String? value) => RealmObjectBase.set(this, 'year', value);

  @override
  bool? get isChecked => RealmObjectBase.get<bool>(this, 'isChecked') as bool?;
  @override
  set isChecked(bool? value) => RealmObjectBase.set(this, 'isChecked', value);

  @override
  bool? get isHotProposition =>
      RealmObjectBase.get<bool>(this, 'isHotProposition') as bool?;
  @override
  set isHotProposition(bool? value) =>
      RealmObjectBase.set(this, 'isHotProposition', value);

  @override
  int? get kilometers => RealmObjectBase.get<int>(this, 'kilometers') as int?;
  @override
  set kilometers(int? value) => RealmObjectBase.set(this, 'kilometers', value);

  @override
  int? get distanceTo => RealmObjectBase.get<int>(this, 'distanceTo') as int?;
  @override
  set distanceTo(int? value) => RealmObjectBase.set(this, 'distanceTo', value);

  @override
  int get price => RealmObjectBase.get<int>(this, 'price') as int;
  @override
  set price(int value) => RealmObjectBase.set(this, 'price', value);

  @override
  Person? get owner => RealmObjectBase.get<Person>(this, 'owner') as Person?;
  @override
  set owner(covariant Person? value) =>
      RealmObjectBase.set(this, 'owner', value);

  @override
  Stream<RealmObjectChanges<Car>> get changes =>
      RealmObjectBase.getChanges<Car>(this);

  @override
  Stream<RealmObjectChanges<Car>> changesFor([List<String>? keyPaths]) =>
      RealmObjectBase.getChangesFor<Car>(this, keyPaths);

  @override
  Car freeze() => RealmObjectBase.freezeObject<Car>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'id': id.toEJson(),
      'manufacturer': manufacturer.toEJson(),
      'model': model.toEJson(),
      'year': year.toEJson(),
      'isChecked': isChecked.toEJson(),
      'isHotProposition': isHotProposition.toEJson(),
      'kilometers': kilometers.toEJson(),
      'distanceTo': distanceTo.toEJson(),
      'price': price.toEJson(),
      'owner': owner.toEJson(),
    };
  }

  static EJsonValue _toEJson(Car value) => value.toEJson();
  static Car _fromEJson(EJsonValue ejson) {
    if (ejson is! Map<String, dynamic>) return raiseInvalidEJson(ejson);
    return switch (ejson) {
      {'id': EJsonValue id, 'manufacturer': EJsonValue manufacturer} => Car(
        fromEJson(id),
        fromEJson(manufacturer),
        model: fromEJson(ejson['model']),
        year: fromEJson(ejson['year']),
        isChecked: fromEJson(ejson['isChecked'], defaultValue: false),
        isHotProposition: fromEJson(
          ejson['isHotProposition'],
          defaultValue: false,
        ),
        kilometers: fromEJson(ejson['kilometers'], defaultValue: 500),
        distanceTo: fromEJson(ejson['distanceTo']),
        price: fromEJson(ejson['price'], defaultValue: 0),
        owner: fromEJson(ejson['owner']),
      ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(Car._);
    register(_toEJson, _fromEJson);
    return const SchemaObject(ObjectType.realmObject, Car, 'Car', [
      SchemaProperty('id', RealmPropertyType.objectid, primaryKey: true),
      SchemaProperty('manufacturer', RealmPropertyType.string),
      SchemaProperty('model', RealmPropertyType.string, optional: true),
      SchemaProperty('year', RealmPropertyType.string, optional: true),
      SchemaProperty('isChecked', RealmPropertyType.bool, optional: true),
      SchemaProperty(
        'isHotProposition',
        RealmPropertyType.bool,
        optional: true,
      ),
      SchemaProperty('kilometers', RealmPropertyType.int, optional: true),
      SchemaProperty('distanceTo', RealmPropertyType.int, optional: true),
      SchemaProperty('price', RealmPropertyType.int),
      SchemaProperty(
        'owner',
        RealmPropertyType.object,
        optional: true,
        linkTarget: 'Person',
      ),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}

class Person extends _Person with RealmEntity, RealmObjectBase, RealmObject {
  static var _defaultsSet = false;

  Person(String name, {int age = 1}) {
    if (!_defaultsSet) {
      _defaultsSet = RealmObjectBase.setDefaults<Person>({'age': 1});
    }
    RealmObjectBase.set(this, 'name', name);
    RealmObjectBase.set(this, 'age', age);
  }

  Person._();

  @override
  String get name => RealmObjectBase.get<String>(this, 'name') as String;
  @override
  set name(String value) => RealmObjectBase.set(this, 'name', value);

  @override
  int get age => RealmObjectBase.get<int>(this, 'age') as int;
  @override
  set age(int value) => RealmObjectBase.set(this, 'age', value);

  @override
  Stream<RealmObjectChanges<Person>> get changes =>
      RealmObjectBase.getChanges<Person>(this);

  @override
  Stream<RealmObjectChanges<Person>> changesFor([List<String>? keyPaths]) =>
      RealmObjectBase.getChangesFor<Person>(this, keyPaths);

  @override
  Person freeze() => RealmObjectBase.freezeObject<Person>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{'name': name.toEJson(), 'age': age.toEJson()};
  }

  static EJsonValue _toEJson(Person value) => value.toEJson();
  static Person _fromEJson(EJsonValue ejson) {
    if (ejson is! Map<String, dynamic>) return raiseInvalidEJson(ejson);
    return switch (ejson) {
      {'name': EJsonValue name} => Person(
        fromEJson(name),
        age: fromEJson(ejson['age'], defaultValue: 1),
      ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(Person._);
    register(_toEJson, _fromEJson);
    return const SchemaObject(ObjectType.realmObject, Person, 'Person', [
      SchemaProperty('name', RealmPropertyType.string),
      SchemaProperty('age', RealmPropertyType.int),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}
