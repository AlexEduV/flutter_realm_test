import 'package:realm/realm.dart';

part 'scheme.realm.dart';

@RealmModel()
class _Car {
  @PrimaryKey()
  late ObjectId id;
  late String carId;
  late String manufacturer;
  late String type;
  String? model;
  String? color;
  String? year;
  String? bodyType;
  String? fuelType;
  String? transmissionType;
  bool? isChecked = false;
  String? hotPromotionDescription;
  int? kilometers = 500;
  int? distanceTo;
  int price = 0;
  _Person? owner;
  late List<String> images;
}

@RealmModel()
class _Person {
  late String name;
  late String id;
  late List<String> linkedIds;
  int age = 1;
}

@RealmModel()
class _User {
  @PrimaryKey()
  late String userId;
  late String firstName;
  late String lastName;
  late String email;
  late String password;
  late bool isLocationPermissionGranted;
  late String region;
  late List<String> favoriteIds;
  _LastSeenCar? lastSeenCar;
}

@RealmModel()
class _LastSeenCar {
  late DateTime date;
  late String? carId;
}
