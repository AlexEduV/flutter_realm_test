import 'package:realm/realm.dart';
import 'package:test_futter_project/domain/entities/car_entity.dart';

part 'scheme.realm.dart';

@RealmModel()
class _Car {
  @PrimaryKey()
  late ObjectId id;
  late String carId;
  late String manufacturer;
  String? model;
  String? year;
  bool? isChecked = false;
  bool? isHotProposition = false;
  int? kilometers = 500;
  int? distanceTo;
  int price = 0;
  _Person? owner;

  CarEntity toEntity(Car car) {
    return CarEntity(
      carId: car.carId,
      model: car.model ?? '',
      manufacturer: car.manufacturer,
      isVerified: car.isChecked ?? false,
      isHotPromotion: car.isHotProposition ?? false,
    );
  }
}

@RealmModel()
class _Person {
  late String name;
  int age = 1;
}
