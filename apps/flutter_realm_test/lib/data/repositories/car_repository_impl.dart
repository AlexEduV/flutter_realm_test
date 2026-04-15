import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:realm/realm.dart';
import 'package:test_flutter_project/data/models/scheme.dart';
import 'package:test_flutter_project/domain/data_sources/local/base_local_storage.dart';
import 'package:test_flutter_project/domain/data_sources/remote/car_remote_data_source.dart';
import 'package:test_flutter_project/domain/repositories/car_repository.dart';

import '../../common/extensions/car_scheme_extension.dart';
import '../../domain/entities/car_entity.dart';

class CarRepositoryImpl implements CarRepository {
  final BaseLocalStorage _localStorage;
  final CarRemoteDataSource _carRemoteDataSource;

  CarRepositoryImpl(this._localStorage, this._carRemoteDataSource);

  @override
  void addCar(CarEntity carEntity) {
    _localStorage.add(carEntity);
  }

  @override
  Stream<List<CarEntity>> watchCars() {
    return _localStorage.watch<Car>().map((changes) {
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

    final dtos = await _carRemoteDataSource.fetchCars();
    for (final dto in dtos) {
      _localStorage.update(CarExtensions.fromDto(dto));
    }

    // 3. Listen to the stream for the 5-second updates
    _carRemoteDataSource.carStream.listen(
      (updatedDtos) {
        for (final dto in updatedDtos) {
          _localStorage.update(CarExtensions.fromDto(dto));
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
    _localStorage.deleteById(id);
  }

  @override
  List<CarEntity> getAllCars() {
    return _localStorage.getAll().toList();
  }

  @override
  void deleteAll() {
    _localStorage.deleteAllCars();
  }

  @override
  CarEntity getCarById(String id) {
    return _localStorage.getCarById(id);
  }

  @override
  int getMaxCarId() {
    return _localStorage.getMaxCarId();
  }
}
