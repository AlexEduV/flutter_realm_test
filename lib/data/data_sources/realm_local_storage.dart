import 'package:realm/realm.dart';
import 'package:test_futter_project/common/extensions/user_scheme_extension.dart';
import 'package:test_futter_project/domain/data_sources/base_local_storage.dart';
import 'package:test_futter_project/domain/entities/user_entity.dart';

import '../../common/extensions/car_scheme_extension.dart';
import '../../domain/entities/car_entity.dart';
import '../models/scheme.dart';

class RealmLocalStorage implements BaseLocalStorage {
  final Realm realm;

  RealmLocalStorage(this.realm);

  @override
  void add(T) {
    realm.write(() {
      realm.add(CarExtensions.fromEntity(T));
    });
  }

  @override
  void update(T) {
    realm.write(() {
      realm.add(T, update: true);
    });
  }

  @override
  Stream watch<T>() {
    return realm.all<Car>().changes;
  }

  @override
  List<CarEntity> getAll() {
    return realm.all<Car>().map((element) => CarEntity.fromSchema(element)).toList();
  }

  @override
  void deleteById(String id) {
    realm.write(() {
      final liveCars = realm.all<Car>().query('carId == \$0', [id]);
      for (final liveCar in liveCars) {
        if (liveCar.isValid) {
          realm.delete(liveCar);
        }
      }
    });
  }

  @override
  void deleteAllCars() {
    realm.write(() {
      realm.deleteAll<Car>();
    });
  }

  @override
  UserEntity initUser() {
    final users = realm.all<User>().map((element) => UserEntity.fromSchema(element)).toList();

    if (users.isNotEmpty) {
      return users.first;
    }

    final user = const UserEntity(
      userId: '1',
      firstName: 'John',
      lastName: 'Adams',
      isLocationPermissionGranted: false,
      favoriteIds: [],
      email: 'mock@gmail.com',
    );

    realm.write(() {
      realm.add(UserExtensions.fromEntity(user));
    });

    return user;
  }

  @override
  CarEntity getCarById(String id) {
    final car = realm.all<Car>().query('carId == \$0', [id]).firstOrNull;
    if (car == null) return CarEntity.empty();

    //todo: maybe watch changes here

    return car.toEntity();
  }

  @override
  int getMaxCarId() {
    final cars = realm.all<Car>();

    final maxCar = cars.toList().reduce((curr, next) {
      return int.parse(curr.carId) > int.parse(next.carId) ? curr : next;
    });

    return int.parse(maxCar.carId);
  }

  @override
  void clearUser() {
    realm.write(() {
      realm.deleteAll<User>();
    });
  }
}
