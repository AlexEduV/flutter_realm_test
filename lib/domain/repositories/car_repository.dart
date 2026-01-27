import 'package:realm/realm.dart';

import '../entities/car_entity.dart';

abstract class CarRepository {
  List<CarEntity> getAllCars();

  void addCar(CarEntity car);

  Future<void> syncCars();

  Stream<List<CarEntity>> watchCars();

  void deleteAll();

  void deleteCarById(ObjectId id);
}
