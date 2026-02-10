import 'package:realm/realm.dart';
import 'package:test_futter_project/domain/entities/car_entity.dart';

import '../entities/user_entity.dart';

abstract class BaseLocalStorage {
  List<CarEntity> getAll();

  void add(T);

  void update(T);

  Stream watch<T>();

  void deleteAll();

  void deleteById(ObjectId id);

  UserEntity initUser();

  CarEntity getCarById(String id);
}
