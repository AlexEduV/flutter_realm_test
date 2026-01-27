import 'dart:async';

import 'package:realm/realm.dart';
import 'package:test_futter_project/data/models/scheme.dart';
import 'package:test_futter_project/domain/repositories/car_repository.dart';

import '../../domain/entities/car_entity.dart';
import '../mocks/mock_car_api_service.dart';

class CarRepositoryImpl implements CarRepository {
  final Realm realm;
  //todo: use abstract class instead
  final MockCarApiService apiService;

  CarRepositoryImpl(this.realm, this.apiService);

  @override
  void addCar(CarEntity carEntity) {
    realm.write(() {
      realm.add(CarExtensions.fromEntity(carEntity));
    });
  }

  @override
  Stream<List<CarEntity>> watchCars() {
    return realm.all<Car>().changes.map((changes) {
      return changes.results.map((schema) => schema.toEntity(schema)).toList();
    });
  }

  @override
  Future<void> syncCars() async {
    final dtos = await apiService.fetchCars();

    realm.write(() {
      for (var dto in dtos) {
        realm.add(CarExtensions.fromDto(dto), update: true);
      }
    });

    // 3. Listen to the stream for the 5-second updates
    apiService.carStream.listen((updatedDtos) {
      realm.write(() {
        for (var dto in updatedDtos) {
          realm.add(CarExtensions.fromDto(dto), update: true);
        }
      });
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
  List<CarEntity> getAllCars() {
    return realm.all<Car>().map((element) => CarEntity.fromSchema(element)).toList();
  }
}
