import 'package:test_flutter_project/domain/entities/car_entity.dart';

import '../../entities/user_entity.dart';

abstract class BaseLocalStorage {
  List<CarEntity> getAll();

  void add(T);

  void update(T);

  Stream watch<T>();

  void deleteAllCars();

  void deleteById(String id);

  UserEntity initUser();

  CarEntity getCarById(String id);

  int getMaxCarId();

  void clearUser();
}
