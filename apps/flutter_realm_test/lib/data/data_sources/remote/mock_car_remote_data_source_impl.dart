import 'dart:async';
import 'dart:math';

import 'package:realm/realm.dart';
import 'package:rxdart/rxdart.dart';
import 'package:test_flutter_project/common/constants/app_asset_routes.dart';
import 'package:test_flutter_project/common/enums/body_type.dart';
import 'package:test_flutter_project/common/enums/car_type.dart';
import 'package:test_flutter_project/common/enums/fuel_type.dart';
import 'package:test_flutter_project/common/enums/promo_type.dart';
import 'package:test_flutter_project/common/enums/transmission_type.dart';
import 'package:test_flutter_project/data/dto/car_dto.dart';
import 'package:test_flutter_project/domain/data_sources/remote/car_remote_data_source.dart';
import 'package:test_flutter_project/domain/entities/engine_entity.dart';
import 'package:test_flutter_project/domain/usecases/database/get_all_cars_use_case.dart';
import 'package:test_flutter_project/domain/usecases/owners/get_owner_by_id_use_case.dart';

import '../../../core/di/injection_container.dart';

class MockCarRemoteDataSourceImpl implements CarRemoteDataSource {
  // 1. Single source of truth
  final _carStreamController = BehaviorSubject<List<CarDto>>();

  @override
  Stream<List<CarDto>> get carStream => _carStreamController.stream;

  late List<CarDto> initialData = [];

  // Track the subscription so we can stop the timer if needed
  StreamSubscription? _liveUpdateSubscription;

  void init() {
    //get all cars from the base
    final cars = serviceLocator<GetAllCarsUseCase>().call();

    //if empty, add three mock elements with ids;
    if (cars.isNotEmpty) {
      initialData = cars.map((element) => CarDto.fromEntity(element)).toList();
    }

    final List<ObjectId> initIds = [ObjectId(), ObjectId(), ObjectId()];

    initialData = [
      CarDto(
        id: initIds[0],
        carId: '1',
        manufacturer: 'Porsche',
        type: CarType.car.name,
        model: '911',
        price: 120000,
        isVerified: true,
        promoType: PromoType.featured,
        year: '2010',
        bodyType: BodyType.coupe.name,
        engine: EngineEntity(type: FuelType.diesel.name),
        transmissionType: TransmissionType.hybrid.name,
        color: 'Yellow',
        owner: serviceLocator<GetOwnerByIdUseCase>().call('1'),
        images: [AppAssetRoutes.porscheYellowImage],
        mileage: 2000,
        distanceTo: 56,
      ),
      CarDto(
        id: initIds[1],
        carId: '2',
        manufacturer: 'Honda',
        model: 'Civic',
        type: CarType.car.name,
        price: 25000,
        isVerified: false,
        promoType: PromoType.bestPrice,
        year: '2007',
        bodyType: BodyType.sedan.name,
        engine: EngineEntity(type: FuelType.hybrid.name),
        transmissionType: TransmissionType.manual.name,
        color: 'Red',
        owner: serviceLocator<GetOwnerByIdUseCase>().call('2'),
        images: [AppAssetRoutes.hondaCivicRedImage],
        mileage: 55607,
        distanceTo: 48,
      ),
      CarDto(
        id: initIds[2],
        carId: '3',
        manufacturer: 'Scania',
        model: 'Nova',
        type: CarType.truck.name,
        price: 50000,
        isVerified: true,
        year: '2002',
        bodyType: BodyType.semi.name,
        engine: EngineEntity(type: FuelType.diesel.name),
        transmissionType: TransmissionType.hybrid.name,
        color: 'Black',
        owner: serviceLocator<GetOwnerByIdUseCase>().call('3'),
        images: [],
        mileage: 18640,
        distanceTo: null,
      ),
    ];
  }

  @override
  Future<List<CarDto>> fetchCars() async {
    // Simulate initial load
    await Future.delayed(const Duration(seconds: 2));

    _carStreamController.add(initialData);

    // 2. Automatically start live updates after the first successful fetch
    await _startHeartbeat();

    return initialData;
  }

  Future<void> _startHeartbeat() async {
    await _liveUpdateSubscription?.cancel(); // Don't start duplicate timers

    _liveUpdateSubscription = Stream.periodic(const Duration(seconds: 5))
        .asyncMap((_) async {
          await Future.delayed(const Duration(milliseconds: 500));
          return _generateRandomUpdates();
        })
        .listen((updatedList) {
          _carStreamController.add(updatedList); // Push updates into the main stream
        });
  }

  List<CarDto> _generateRandomUpdates() {
    return initialData.map((car) {
      final random = Random();
      int? distanceTo;
      switch (car.carId) {
        case '1':
          distanceTo = random.nextInt(60);
          break;
        case '2':
          distanceTo = random.nextInt(50);
          break;
        case '3':
          distanceTo = random.nextInt(50);
          break;
      }
      return car.copyWith(distanceTo: distanceTo);
    }).toList();
  }

  @override
  Future<void> dispose() async {
    await _liveUpdateSubscription?.cancel();
    await _carStreamController.close();
  }
}
