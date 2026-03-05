import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:realm/realm.dart';
import 'package:test_futter_project/data/models/scheme.dart';
import 'package:test_futter_project/domain/data_sources/base_local_storage.dart';
import 'package:test_futter_project/domain/data_sources/car_api_service.dart';
import 'package:test_futter_project/domain/repositories/car_repository.dart';

import '../../common/extensions/car_scheme_extension.dart';
import '../../domain/entities/car_entity.dart';

class CarRepositoryImpl implements CarRepository {
  final BaseLocalStorage localStorage;
  final CarApiService apiService;

  CarRepositoryImpl(this.localStorage, this.apiService);

  @override
  void addCar(CarEntity carEntity) {
    localStorage.add(carEntity);
  }

  @override
  Stream<List<CarEntity>> watchCars() {
    return localStorage.watch<Car>().map((changes) {
      final realmChanges = changes as RealmResultsChanges<Car>;

      final results = realmChanges.results;
      final entities = results.map((car) => car.toEntity()).toList();

      // Sort by carId
      entities.sort((a, b) => a.carId.compareTo(b.carId));

      return entities;
    });
  }

  @override
  Future<void> syncCars() async {
    deleteAll();

    final dtos = await apiService.fetchCars();
    for (final dto in dtos) {
      localStorage.update(CarExtensions.fromDto(dto));
    }

    // 3. Listen to the stream for the 5-second updates
    apiService.carStream.listen(
      (updatedDtos) {
        for (final dto in updatedDtos) {
          localStorage.update(CarExtensions.fromDto(dto));
        }
      },
      onError: (error, _) {
        debugPrint('car stream error: $error');
      },
      onDone: () {
        debugPrint('car stream closed.');
      },
    );
  }

  @override
  void deleteCarById(String id) {
    localStorage.deleteById(id);
  }

  @override
  List<CarEntity> getAllCars() {
    return localStorage.getAll().toList();
  }

  @override
  void deleteAll() {
    localStorage.deleteAllCars();
  }

  @override
  CarEntity getCarById(String id) {
    return localStorage.getCarById(id);
  }

  @override
  int getMaxCarId() {
    return localStorage.getMaxCarId();
  }
}
