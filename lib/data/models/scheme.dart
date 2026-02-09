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
  String? year;
  String? bodyType;
  String? fuelType;
  String? transmissionType;
  bool? isChecked = false;
  bool? isHotProposition = false;
  int? kilometers = 500;
  int? distanceTo;
  int price = 0;
  _Person? owner;
}

@RealmModel()
class _Person {
  late String name;
  int age = 1;
}

@RealmModel()
class _User {
  late String userId;
  late String firstName;
  late String lastName;
  late bool isLocationPermissionGranted;
  late List<String> favoriteIds;
}
