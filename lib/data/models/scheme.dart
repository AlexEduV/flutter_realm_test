import 'package:realm/realm.dart';

part 'scheme.realm.dart';

@RealmModel()
class _Car {
  @PrimaryKey()
  late ObjectId id;
  late String manufacturer;
  String? model;
  String? year;
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
