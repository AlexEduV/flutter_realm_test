import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realm/realm.dart';
import 'package:test_flutter_project/data/models/scheme.dart';
import 'package:test_flutter_project/domain/data_sources/local/app_local_storage.dart';
import 'package:test_flutter_project/domain/data_sources/remote/car_remote_data_source.dart';
import 'package:test_flutter_project/domain/repositories/car_repository.dart';
import 'package:test_flutter_project/domain/services/logging_service.dart';

import '../../domain/entities/car_entity.dart';
import '../mappers/car_scheme_extension.dart';

class CarRepositoryImpl with Closable implements CarRepository {
  CarRepositoryImpl(this._localStorage, this._carRemoteDataSource, this._loggingService);

  final AppLocalStorage _localStorage;
  final CarRemoteDataSource _carRemoteDataSource;
  final LoggingService _loggingService;

  StreamSubscription? _carStreamSubscription;
  bool? _isClosed;

  @override
  void addCar(CarEntity carEntity) {
    _localStorage.addCar(carEntity);
  }

  @override
  Stream<List<CarEntity>> watchCars() {
    return _localStorage.watchCars().map((changes) {
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
      _localStorage.updateCar(CarEntity.fromDto(dto));
    }

    // 3. Listen to the stream for the 5-second updates
    await _carStreamSubscription?.cancel();
    _carStreamSubscription = _carRemoteDataSource.carStream.listen(
      (updatedDtos) {
        for (final dto in updatedDtos) {
          _localStorage.updateCar(CarEntity.fromDto(dto));
        }
      },
      onError: (error, stackTrace) {
        _loggingService.error('car stream error: $error', stackTrace: stackTrace);
      },
      onDone: () {
        _loggingService.info('car stream closed.');
      },
    );
    _isClosed = false;
  }

  @override
  void deleteCarById(String id) {
    _localStorage.deleteCarById(id);
  }

  @override
  List<CarEntity> getAllCars() {
    return _localStorage.getAllCars().toList();
  }

  @override
  void deleteAll() {
    _localStorage.deleteAllCars();
  }

  @override
  CarEntity? getCarById(String id) {
    return _localStorage.getCarById(id);
  }

  @override
  int getMaxCarId() {
    return _localStorage.getMaxCarId();
  }

  @override
  FutureOr<void> close() async {
    await _carStreamSubscription?.cancel();
    _isClosed = true;
  }

  @override
  bool get isClosed => _isClosed ?? true;
}
