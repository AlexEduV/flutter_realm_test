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
    String carId,
    String manufacturer,
    String type, {
    String? model,
    String? color,
    String? year,
    String? bodyType,
    String? fuelType,
    String? transmissionType,
    bool? isChecked = false,
    String? hotPromotionDescription,
    int? kilometers = 500,
    int? distanceTo,
    int price = 0,
    Person? owner,
    Iterable<String> images = const [],
  }) {
    if (!_defaultsSet) {
      _defaultsSet = RealmObjectBase.setDefaults<Car>({
        'isChecked': false,
        'kilometers': 500,
        'price': 0,
      });
    }
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'carId', carId);
    RealmObjectBase.set(this, 'manufacturer', manufacturer);
    RealmObjectBase.set(this, 'type', type);
    RealmObjectBase.set(this, 'model', model);
    RealmObjectBase.set(this, 'color', color);
    RealmObjectBase.set(this, 'year', year);
    RealmObjectBase.set(this, 'bodyType', bodyType);
    RealmObjectBase.set(this, 'fuelType', fuelType);
    RealmObjectBase.set(this, 'transmissionType', transmissionType);
    RealmObjectBase.set(this, 'isChecked', isChecked);
    RealmObjectBase.set(
      this,
      'hotPromotionDescription',
      hotPromotionDescription,
    );
    RealmObjectBase.set(this, 'kilometers', kilometers);
    RealmObjectBase.set(this, 'distanceTo', distanceTo);
    RealmObjectBase.set(this, 'price', price);
    RealmObjectBase.set(this, 'owner', owner);
    RealmObjectBase.set<RealmList<String>>(
      this,
      'images',
      RealmList<String>(images),
    );
  }

  Car._();

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
  String? get model => RealmObjectBase.get<String>(this, 'model') as String?;
  @override
  set model(String? value) => RealmObjectBase.set(this, 'model', value);

  @override
  String? get color => RealmObjectBase.get<String>(this, 'color') as String?;
  @override
  set color(String? value) => RealmObjectBase.set(this, 'color', value);

  @override
  String? get year => RealmObjectBase.get<String>(this, 'year') as String?;
  @override
  set year(String? value) => RealmObjectBase.set(this, 'year', value);

  @override
  String? get bodyType =>
      RealmObjectBase.get<String>(this, 'bodyType') as String?;
  @override
  set bodyType(String? value) => RealmObjectBase.set(this, 'bodyType', value);

  @override
  String? get fuelType =>
      RealmObjectBase.get<String>(this, 'fuelType') as String?;
  @override
  set fuelType(String? value) => RealmObjectBase.set(this, 'fuelType', value);

  @override
  String? get transmissionType =>
      RealmObjectBase.get<String>(this, 'transmissionType') as String?;
  @override
  set transmissionType(String? value) =>
      RealmObjectBase.set(this, 'transmissionType', value);

  @override
  bool? get isChecked => RealmObjectBase.get<bool>(this, 'isChecked') as bool?;
  @override
  set isChecked(bool? value) => RealmObjectBase.set(this, 'isChecked', value);

  @override
  String? get hotPromotionDescription =>
      RealmObjectBase.get<String>(this, 'hotPromotionDescription') as String?;
  @override
  set hotPromotionDescription(String? value) =>
      RealmObjectBase.set(this, 'hotPromotionDescription', value);

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
  RealmList<String> get images =>
      RealmObjectBase.get<String>(this, 'images') as RealmList<String>;
  @override
  set images(covariant RealmList<String> value) =>
      throw RealmUnsupportedSetError();

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
      'carId': carId.toEJson(),
      'manufacturer': manufacturer.toEJson(),
      'type': type.toEJson(),
      'model': model.toEJson(),
      'color': color.toEJson(),
      'year': year.toEJson(),
      'bodyType': bodyType.toEJson(),
      'fuelType': fuelType.toEJson(),
      'transmissionType': transmissionType.toEJson(),
      'isChecked': isChecked.toEJson(),
      'hotPromotionDescription': hotPromotionDescription.toEJson(),
      'kilometers': kilometers.toEJson(),
      'distanceTo': distanceTo.toEJson(),
      'price': price.toEJson(),
      'owner': owner.toEJson(),
      'images': images.toEJson(),
    };
  }

  static EJsonValue _toEJson(Car value) => value.toEJson();
  static Car _fromEJson(EJsonValue ejson) {
    if (ejson is! Map<String, dynamic>) return raiseInvalidEJson(ejson);
    return switch (ejson) {
      {
        'id': EJsonValue id,
        'carId': EJsonValue carId,
        'manufacturer': EJsonValue manufacturer,
        'type': EJsonValue type,
      } =>
        Car(
          fromEJson(id),
          fromEJson(carId),
          fromEJson(manufacturer),
          fromEJson(type),
          model: fromEJson(ejson['model']),
          color: fromEJson(ejson['color']),
          year: fromEJson(ejson['year']),
          bodyType: fromEJson(ejson['bodyType']),
          fuelType: fromEJson(ejson['fuelType']),
          transmissionType: fromEJson(ejson['transmissionType']),
          isChecked: fromEJson(ejson['isChecked'], defaultValue: false),
          hotPromotionDescription: fromEJson(ejson['hotPromotionDescription']),
          kilometers: fromEJson(ejson['kilometers'], defaultValue: 500),
          distanceTo: fromEJson(ejson['distanceTo']),
          price: fromEJson(ejson['price'], defaultValue: 0),
          owner: fromEJson(ejson['owner']),
          images: fromEJson(ejson['images']),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(Car._);
    register(_toEJson, _fromEJson);
    return const SchemaObject(ObjectType.realmObject, Car, 'Car', [
      SchemaProperty('id', RealmPropertyType.objectid, primaryKey: true),
      SchemaProperty('carId', RealmPropertyType.string),
      SchemaProperty('manufacturer', RealmPropertyType.string),
      SchemaProperty('type', RealmPropertyType.string),
      SchemaProperty('model', RealmPropertyType.string, optional: true),
      SchemaProperty('color', RealmPropertyType.string, optional: true),
      SchemaProperty('year', RealmPropertyType.string, optional: true),
      SchemaProperty('bodyType', RealmPropertyType.string, optional: true),
      SchemaProperty('fuelType', RealmPropertyType.string, optional: true),
      SchemaProperty(
        'transmissionType',
        RealmPropertyType.string,
        optional: true,
      ),
      SchemaProperty('isChecked', RealmPropertyType.bool, optional: true),
      SchemaProperty(
        'hotPromotionDescription',
        RealmPropertyType.string,
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
      SchemaProperty(
        'images',
        RealmPropertyType.string,
        collectionType: RealmCollectionType.list,
      ),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}

class Person extends _Person with RealmEntity, RealmObjectBase, RealmObject {
  static var _defaultsSet = false;

  Person(
    String firstName,
    String lastName,
    String id, {
    Iterable<String> linkedIds = const [],
    String? imageSrc,
    int age = 1,
  }) {
    if (!_defaultsSet) {
      _defaultsSet = RealmObjectBase.setDefaults<Person>({'age': 1});
    }
    RealmObjectBase.set(this, 'firstName', firstName);
    RealmObjectBase.set(this, 'lastName', lastName);
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set<RealmList<String>>(
      this,
      'linkedIds',
      RealmList<String>(linkedIds),
    );
    RealmObjectBase.set(this, 'imageSrc', imageSrc);
    RealmObjectBase.set(this, 'age', age);
  }

  Person._();

  @override
  String get firstName =>
      RealmObjectBase.get<String>(this, 'firstName') as String;
  @override
  set firstName(String value) => RealmObjectBase.set(this, 'firstName', value);

  @override
  String get lastName =>
      RealmObjectBase.get<String>(this, 'lastName') as String;
  @override
  set lastName(String value) => RealmObjectBase.set(this, 'lastName', value);

  @override
  String get id => RealmObjectBase.get<String>(this, 'id') as String;
  @override
  set id(String value) => RealmObjectBase.set(this, 'id', value);

  @override
  RealmList<String> get linkedIds =>
      RealmObjectBase.get<String>(this, 'linkedIds') as RealmList<String>;
  @override
  set linkedIds(covariant RealmList<String> value) =>
      throw RealmUnsupportedSetError();

  @override
  String? get imageSrc =>
      RealmObjectBase.get<String>(this, 'imageSrc') as String?;
  @override
  set imageSrc(String? value) => RealmObjectBase.set(this, 'imageSrc', value);

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
    return <String, dynamic>{
      'firstName': firstName.toEJson(),
      'lastName': lastName.toEJson(),
      'id': id.toEJson(),
      'linkedIds': linkedIds.toEJson(),
      'imageSrc': imageSrc.toEJson(),
      'age': age.toEJson(),
    };
  }

  static EJsonValue _toEJson(Person value) => value.toEJson();
  static Person _fromEJson(EJsonValue ejson) {
    if (ejson is! Map<String, dynamic>) return raiseInvalidEJson(ejson);
    return switch (ejson) {
      {
        'firstName': EJsonValue firstName,
        'lastName': EJsonValue lastName,
        'id': EJsonValue id,
      } =>
        Person(
          fromEJson(firstName),
          fromEJson(lastName),
          fromEJson(id),
          linkedIds: fromEJson(ejson['linkedIds']),
          imageSrc: fromEJson(ejson['imageSrc']),
          age: fromEJson(ejson['age'], defaultValue: 1),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(Person._);
    register(_toEJson, _fromEJson);
    return const SchemaObject(ObjectType.realmObject, Person, 'Person', [
      SchemaProperty('firstName', RealmPropertyType.string),
      SchemaProperty('lastName', RealmPropertyType.string),
      SchemaProperty('id', RealmPropertyType.string),
      SchemaProperty(
        'linkedIds',
        RealmPropertyType.string,
        collectionType: RealmCollectionType.list,
      ),
      SchemaProperty('imageSrc', RealmPropertyType.string, optional: true),
      SchemaProperty('age', RealmPropertyType.int),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}

class User extends _User with RealmEntity, RealmObjectBase, RealmObject {
  User(
    String userId,
    String firstName,
    String lastName,
    String email,
    String password,
    bool isLocationPermissionGranted,
    String region, {
    Iterable<String> favoriteIds = const [],
    Iterable<String> createdIds = const [],
    Iterable<String> viewedIds = const [],
    LastSeenCar? lastSeenCar,
    String? avatarImage,
  }) {
    RealmObjectBase.set(this, 'userId', userId);
    RealmObjectBase.set(this, 'firstName', firstName);
    RealmObjectBase.set(this, 'lastName', lastName);
    RealmObjectBase.set(this, 'email', email);
    RealmObjectBase.set(this, 'password', password);
    RealmObjectBase.set(
      this,
      'isLocationPermissionGranted',
      isLocationPermissionGranted,
    );
    RealmObjectBase.set(this, 'region', region);
    RealmObjectBase.set<RealmList<String>>(
      this,
      'favoriteIds',
      RealmList<String>(favoriteIds),
    );
    RealmObjectBase.set<RealmList<String>>(
      this,
      'createdIds',
      RealmList<String>(createdIds),
    );
    RealmObjectBase.set<RealmList<String>>(
      this,
      'viewedIds',
      RealmList<String>(viewedIds),
    );
    RealmObjectBase.set(this, 'lastSeenCar', lastSeenCar);
    RealmObjectBase.set(this, 'avatarImage', avatarImage);
  }

  User._();

  @override
  String get userId => RealmObjectBase.get<String>(this, 'userId') as String;
  @override
  set userId(String value) => RealmObjectBase.set(this, 'userId', value);

  @override
  String get firstName =>
      RealmObjectBase.get<String>(this, 'firstName') as String;
  @override
  set firstName(String value) => RealmObjectBase.set(this, 'firstName', value);

  @override
  String get lastName =>
      RealmObjectBase.get<String>(this, 'lastName') as String;
  @override
  set lastName(String value) => RealmObjectBase.set(this, 'lastName', value);

  @override
  String get email => RealmObjectBase.get<String>(this, 'email') as String;
  @override
  set email(String value) => RealmObjectBase.set(this, 'email', value);

  @override
  String get password =>
      RealmObjectBase.get<String>(this, 'password') as String;
  @override
  set password(String value) => RealmObjectBase.set(this, 'password', value);

  @override
  bool get isLocationPermissionGranted =>
      RealmObjectBase.get<bool>(this, 'isLocationPermissionGranted') as bool;
  @override
  set isLocationPermissionGranted(bool value) =>
      RealmObjectBase.set(this, 'isLocationPermissionGranted', value);

  @override
  String get region => RealmObjectBase.get<String>(this, 'region') as String;
  @override
  set region(String value) => RealmObjectBase.set(this, 'region', value);

  @override
  RealmList<String> get favoriteIds =>
      RealmObjectBase.get<String>(this, 'favoriteIds') as RealmList<String>;
  @override
  set favoriteIds(covariant RealmList<String> value) =>
      throw RealmUnsupportedSetError();

  @override
  RealmList<String> get createdIds =>
      RealmObjectBase.get<String>(this, 'createdIds') as RealmList<String>;
  @override
  set createdIds(covariant RealmList<String> value) =>
      throw RealmUnsupportedSetError();

  @override
  RealmList<String> get viewedIds =>
      RealmObjectBase.get<String>(this, 'viewedIds') as RealmList<String>;
  @override
  set viewedIds(covariant RealmList<String> value) =>
      throw RealmUnsupportedSetError();

  @override
  LastSeenCar? get lastSeenCar =>
      RealmObjectBase.get<LastSeenCar>(this, 'lastSeenCar') as LastSeenCar?;
  @override
  set lastSeenCar(covariant LastSeenCar? value) =>
      RealmObjectBase.set(this, 'lastSeenCar', value);

  @override
  String? get avatarImage =>
      RealmObjectBase.get<String>(this, 'avatarImage') as String?;
  @override
  set avatarImage(String? value) =>
      RealmObjectBase.set(this, 'avatarImage', value);

  @override
  Stream<RealmObjectChanges<User>> get changes =>
      RealmObjectBase.getChanges<User>(this);

  @override
  Stream<RealmObjectChanges<User>> changesFor([List<String>? keyPaths]) =>
      RealmObjectBase.getChangesFor<User>(this, keyPaths);

  @override
  User freeze() => RealmObjectBase.freezeObject<User>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'userId': userId.toEJson(),
      'firstName': firstName.toEJson(),
      'lastName': lastName.toEJson(),
      'email': email.toEJson(),
      'password': password.toEJson(),
      'isLocationPermissionGranted': isLocationPermissionGranted.toEJson(),
      'region': region.toEJson(),
      'favoriteIds': favoriteIds.toEJson(),
      'createdIds': createdIds.toEJson(),
      'viewedIds': viewedIds.toEJson(),
      'lastSeenCar': lastSeenCar.toEJson(),
      'avatarImage': avatarImage.toEJson(),
    };
  }

  static EJsonValue _toEJson(User value) => value.toEJson();
  static User _fromEJson(EJsonValue ejson) {
    if (ejson is! Map<String, dynamic>) return raiseInvalidEJson(ejson);
    return switch (ejson) {
      {
        'userId': EJsonValue userId,
        'firstName': EJsonValue firstName,
        'lastName': EJsonValue lastName,
        'email': EJsonValue email,
        'password': EJsonValue password,
        'isLocationPermissionGranted': EJsonValue isLocationPermissionGranted,
        'region': EJsonValue region,
      } =>
        User(
          fromEJson(userId),
          fromEJson(firstName),
          fromEJson(lastName),
          fromEJson(email),
          fromEJson(password),
          fromEJson(isLocationPermissionGranted),
          fromEJson(region),
          favoriteIds: fromEJson(ejson['favoriteIds']),
          createdIds: fromEJson(ejson['createdIds']),
          viewedIds: fromEJson(ejson['viewedIds']),
          lastSeenCar: fromEJson(ejson['lastSeenCar']),
          avatarImage: fromEJson(ejson['avatarImage']),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(User._);
    register(_toEJson, _fromEJson);
    return const SchemaObject(ObjectType.realmObject, User, 'User', [
      SchemaProperty('userId', RealmPropertyType.string, primaryKey: true),
      SchemaProperty('firstName', RealmPropertyType.string),
      SchemaProperty('lastName', RealmPropertyType.string),
      SchemaProperty('email', RealmPropertyType.string),
      SchemaProperty('password', RealmPropertyType.string),
      SchemaProperty('isLocationPermissionGranted', RealmPropertyType.bool),
      SchemaProperty('region', RealmPropertyType.string),
      SchemaProperty(
        'favoriteIds',
        RealmPropertyType.string,
        collectionType: RealmCollectionType.list,
      ),
      SchemaProperty(
        'createdIds',
        RealmPropertyType.string,
        collectionType: RealmCollectionType.list,
      ),
      SchemaProperty(
        'viewedIds',
        RealmPropertyType.string,
        collectionType: RealmCollectionType.list,
      ),
      SchemaProperty(
        'lastSeenCar',
        RealmPropertyType.object,
        optional: true,
        linkTarget: 'LastSeenCar',
      ),
      SchemaProperty('avatarImage', RealmPropertyType.string, optional: true),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}

class LastSeenCar extends _LastSeenCar
    with RealmEntity, RealmObjectBase, RealmObject {
  LastSeenCar(DateTime date, {String? carId}) {
    RealmObjectBase.set(this, 'date', date);
    RealmObjectBase.set(this, 'carId', carId);
  }

  LastSeenCar._();

  @override
  DateTime get date => RealmObjectBase.get<DateTime>(this, 'date') as DateTime;
  @override
  set date(DateTime value) => RealmObjectBase.set(this, 'date', value);

  @override
  String? get carId => RealmObjectBase.get<String>(this, 'carId') as String?;
  @override
  set carId(String? value) => RealmObjectBase.set(this, 'carId', value);

  @override
  Stream<RealmObjectChanges<LastSeenCar>> get changes =>
      RealmObjectBase.getChanges<LastSeenCar>(this);

  @override
  Stream<RealmObjectChanges<LastSeenCar>> changesFor([
    List<String>? keyPaths,
  ]) => RealmObjectBase.getChangesFor<LastSeenCar>(this, keyPaths);

  @override
  LastSeenCar freeze() => RealmObjectBase.freezeObject<LastSeenCar>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{'date': date.toEJson(), 'carId': carId.toEJson()};
  }

  static EJsonValue _toEJson(LastSeenCar value) => value.toEJson();
  static LastSeenCar _fromEJson(EJsonValue ejson) {
    if (ejson is! Map<String, dynamic>) return raiseInvalidEJson(ejson);
    return switch (ejson) {
      {'date': EJsonValue date} => LastSeenCar(
        fromEJson(date),
        carId: fromEJson(ejson['carId']),
      ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(LastSeenCar._);
    register(_toEJson, _fromEJson);
    return const SchemaObject(
      ObjectType.realmObject,
      LastSeenCar,
      'LastSeenCar',
      [
        SchemaProperty('date', RealmPropertyType.timestamp),
        SchemaProperty('carId', RealmPropertyType.string, optional: true),
      ],
    );
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}
