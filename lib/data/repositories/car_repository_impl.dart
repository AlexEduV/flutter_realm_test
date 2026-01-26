import 'package:realm/realm.dart';
import 'package:test_futter_project/data/models/scheme.dart';
import 'package:test_futter_project/domain/repositories/car_repository.dart';

class CarRepositoryImpl implements CarRepository {
  final Realm realm;

  CarRepositoryImpl(this.realm);

  @override
  void addCar(Car car) {
    realm.write(() {
      realm.add(car);
    });
  }

  @override
  void deleteCarById(ObjectId id) {
    realm.write(() {
      final liveCar = realm.find<Car>(id);
      if (liveCar != null && liveCar.isValid) {
        realm.delete(liveCar);
      }
    });
  }

  @override
  List<Car> getAllCars() {
    return realm.all<Car>().toList();
  }
}
