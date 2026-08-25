import 'dart:math';

import 'package:realm/realm.dart';
import 'package:test_flutter_project/common/extensions/user_scheme_extension.dart';
import 'package:test_flutter_project/domain/data_sources/local/app_local_storage.dart';
import 'package:test_flutter_project/domain/entities/user_entity.dart';

import '../../../common/extensions/car_scheme_extension.dart';
import '../../../domain/entities/car_entity.dart';
import '../../models/scheme.dart';

class RealmLocalStorage implements AppLocalStorage {
  RealmLocalStorage(this._realm);

  final Realm _realm;

  @override
  void addCar(CarEntity car) {
    _realm.write(() {
      _realm.add(CarExtensions.fromEntity(car));
    });
  }

  @override
  void updateCar(CarEntity car) {
    _realm.write(() {
      _realm.add(CarExtensions.fromEntity(car), update: true);
    });
  }

  @override
  Stream watchCars() {
    return _realm.all<Car>().changes;
  }

  @override
  List<CarEntity> getAllCars() {
    return _realm.all<Car>().map((element) => CarEntity.fromSchema(element)).toList();
  }

  @override
  void deleteCarById(String id) {
    _realm.write(() {
      final liveCars = _realm.query<Car>('carId == \$0', [id]);
      for (final liveCar in liveCars) {
        if (!liveCar.isValid) continue;
        _realm.delete(liveCar);
      }
    });
  }

  @override
  void deleteAllCars() {
    _realm.write(() {
      _realm.deleteAll<Car>();
    });
  }

  @override
  CarEntity? getCarById(String id) {
    final car = _realm.query<Car>('carId == \$0', [id]).firstOrNull;
    if (car == null) return null;

    return car.toEntity();
  }

  @override
  int getMaxCarId() {
    final cars = _realm.all<Car>();
    if (cars.isEmpty) return 0;
    return cars.map((c) => int.parse(c.carId)).reduce(max);
  }

  @override
  UserEntity initUser() {
    final users = _realm.all<User>().map((element) => UserEntity.fromSchema(element)).toList();

    if (users.isNotEmpty) {
      return users.first;
    }

    final user = const UserEntity(
      userId: '0',
      firstName: 'Guest',
      lastName: 'Account',
      isLocationPermissionGranted: null,
      favoriteIds: [],
      createdIds: [],
      viewedIds: [],
      email: 'mock@gmail.com',
      lastSeenCar: null,
      password: '',
      region: 'uk',
      avatarImageSrc: null,
    );

    _realm.write(() {
      _realm.add(UserExtensions.fromEntity(user));
    });

    return user;
  }

  @override
  void updateUser(UserEntity user) {
    _realm.write(() {
      _realm.add(UserExtensions.fromEntity(user), update: true);
    });
  }

  @override
  void clearUser() {
    _realm.write(() {
      _realm.deleteAll<User>();
    });
  }
}
