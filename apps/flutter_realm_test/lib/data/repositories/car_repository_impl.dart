import 'dart:async';

import 'package:realm/realm.dart';
import 'package:test_flutter_project/data/models/scheme.dart';
import 'package:test_flutter_project/domain/data_sources/local/app_local_storage.dart';
import 'package:test_flutter_project/domain/data_sources/remote/car_remote_data_source.dart';
import 'package:test_flutter_project/domain/repositories/car_repository.dart';
import 'package:test_flutter_project/domain/services/logging_service.dart';

import '../../common/extensions/car_scheme_extension.dart';
import '../../domain/entities/car_entity.dart';

class CarRepositoryImpl implements CarRepository {
  CarRepositoryImpl(this._localStorage, this._carRemoteDataSource, this._loggingService);

  final AppLocalStorage _localStorage;
  final CarRemoteDataSource _carRemoteDataSource;
  final LoggingService _loggingService;

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
    dtos.map((element) => _localStorage.update(CarExtensions.fromDto(element)));

    // 3. Listen to the stream for the 5-second updates
    _carRemoteDataSource.carStream.listen(
      (updatedDtos) {
        updatedDtos.map((element) => _localStorage.update(CarExtensions.fromDto(element)));
      },
      onError: (error, stackTrace) {
        _loggingService.error('car stream error: $error', stackTrace: stackTrace);
      },
      onDone: () {
        _loggingService.info('car stream closed.');
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
