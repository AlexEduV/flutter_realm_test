import 'package:realm/realm.dart';

import '../../data/models/scheme.dart';

abstract class CarRepository {
  List<Car> getAllCars();

  void addCar(Car car);

  void deleteCarById(ObjectId id);
}
