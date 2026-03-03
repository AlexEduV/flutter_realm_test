import 'dart:async';
import 'dart:math';

import 'package:realm/realm.dart';
import 'package:rxdart/rxdart.dart';
import 'package:test_futter_project/common/app_asset_routes.dart';
import 'package:test_futter_project/common/enums/body_type.dart';
import 'package:test_futter_project/common/enums/car_type.dart';
import 'package:test_futter_project/common/enums/fuel_type.dart';
import 'package:test_futter_project/common/enums/promo_type.dart';
import 'package:test_futter_project/common/enums/transmission_type.dart';
import 'package:test_futter_project/data/dto/car_dto.dart';
import 'package:test_futter_project/domain/data_sources/car_api_service.dart';
import 'package:test_futter_project/domain/models/owner_model.dart';

class MockCarApiService implements CarApiService {
  // 1. Single source of truth
  final _carStreamController = BehaviorSubject<List<CarDto>>();

  @override
  Stream<List<CarDto>> get carStream => _carStreamController.stream;

  List<ObjectId> initIds = [ObjectId(), ObjectId(), ObjectId()];

  // Track the subscription so we can stop the timer if needed
  StreamSubscription? _liveUpdateSubscription;

  @override
  Future<List<CarDto>> fetchCars() async {
    // Simulate initial load
    await Future.delayed(const Duration(seconds: 2));

    //todo: remove duplications between initial data and the generate in the heartbeat;
    final initialData = [
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
        fuelType: FuelType.diesel.name,
        transmissionType: TransmissionType.hybrid.name,
        color: 'Yellow',
        owner: OwnerModel(id: '1', name: 'James Norrington', linkedItemIds: ['1', '25']),
        images: [AppAssetRoutes.porscheYellowImage],
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
        fuelType: FuelType.hybrid.name,
        transmissionType: TransmissionType.manual.name,
        color: 'Red',
        owner: OwnerModel(id: '2', name: 'Jack Smith', linkedItemIds: ['2', '23']),
        images: [AppAssetRoutes.hondaCivicRedImage],
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
        fuelType: FuelType.diesel.name,
        transmissionType: TransmissionType.hybrid.name,
        color: 'Black',
        owner: OwnerModel(id: '3', name: 'Arya Stark', linkedItemIds: ['3', '26']),
        images: [],
      ),
    ];

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
    return [
      CarDto(
        id: initIds[0],
        carId: '1',
        manufacturer: 'Porsche',
        model: '911',
        type: CarType.car.name,
        price: 120000 + Random().nextInt(1000), // Randomize!
        distanceTo: Random().nextInt(60),
        isVerified: true,
        promoType: PromoType.featured,
        year: '2010',
        bodyType: BodyType.coupe.name,
        fuelType: FuelType.diesel.name,
        transmissionType: TransmissionType.hybrid.name,
        color: 'Yellow',
        owner: OwnerModel(id: '1', name: 'James Norrington', linkedItemIds: ['1', '25']),
        images: [AppAssetRoutes.porscheYellowImage],
      ),
      CarDto(
        id: initIds[1],
        carId: '2',
        manufacturer: 'Honda',
        model: 'Civic',
        type: CarType.car.name,
        price: 25000 + Random().nextInt(500), // Randomize!
        distanceTo: Random().nextInt(50),
        isVerified: false,
        promoType: PromoType.bestPrice,
        year: '2007',
        bodyType: BodyType.sedan.name,
        fuelType: FuelType.hybrid.name,
        transmissionType: TransmissionType.manual.name,
        color: 'Red',
        owner: OwnerModel(id: '2', name: 'Jack Smith', linkedItemIds: ['2', '23']),
        images: [AppAssetRoutes.hondaCivicRedImage],
      ),
      CarDto(
        id: initIds[2],
        carId: '3',
        manufacturer: 'Scania',
        model: 'Nova',
        type: CarType.truck.name,
        price: 50000 + Random().nextInt(1000),
        distanceTo: Random().nextInt(50),
        isVerified: true,
        year: '2002',
        bodyType: BodyType.semi.name,
        fuelType: FuelType.diesel.name,
        transmissionType: TransmissionType.hybrid.name,
        color: 'Black',
        owner: OwnerModel(id: '3', name: 'Arya Stark', linkedItemIds: ['3', '26']),
        images: [],
      ),
    ];
  }

  @override
  Future<void> dispose() async {
    await _liveUpdateSubscription?.cancel();
    await _carStreamController.close();
  }
}
