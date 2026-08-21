import 'package:test_flutter_project/domain/entities/car_entity.dart';

import '../../entities/user_entity.dart';

abstract interface class AppLocalStorage {
  List<CarEntity> getAllCars();

  void addCar(CarEntity car);

  void updateCar(CarEntity car);

  void updateUser(UserEntity user);

  Stream watchCars();

  void deleteAllCars();

  void deleteCarById(String id);

  CarEntity? getCarById(String id);

  int getMaxCarId();

  UserEntity initUser();

  void clearUser();
}
