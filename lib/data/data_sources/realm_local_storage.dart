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
      firstName: 'Guest',
      lastName: 'Account',
      isLocationPermissionGranted: false,
      favoriteIds: [],
      createdIds: [],
      viewedIds: [],
      email: 'mock@gmail.com',
      lastSeenCar: null,
      password: '',
      region: 'uk',
      avatarImageSrc: null,
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

  @override
  void updateUserFull(UserEntity user) {
    final currentUser = realm.all<User>().first;

    realm.write(() {
      currentUser.firstName = user.firstName;
      currentUser.lastName = user.lastName;
      currentUser.email = user.email;
      currentUser.password = user.password;
      currentUser.avatarImage = user.avatarImageSrc;
      currentUser.isLocationPermissionGranted = user.isLocationPermissionGranted;
      currentUser.region = user.region;
      currentUser.lastSeenCar = UserExtensions.getLastSeenCar(user.lastSeenCar);

      currentUser.favoriteIds
        ..clear()
        ..addAll(user.favoriteIds);

      currentUser.viewedIds
        ..clear()
        ..addAll(user.viewedIds);

      currentUser.createdIds
        ..clear()
        ..addAll(user.createdIds);
    });
  }
}
