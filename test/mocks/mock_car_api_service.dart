import 'dart:async'; // Import TimerStream
import 'dart:math';

import 'package:rxdart/rxdart.dart';
import 'package:test_futter_project/data/dto/car_dto.dart';

class MockCarApiService {
  // 1. Single source of truth
  final _carStreamController = BehaviorSubject<List<CarDto>>();
  Stream<List<CarDto>> get carStream => _carStreamController.stream;

  // Track the subscription so we can stop the timer if needed
  StreamSubscription? _liveUpdateSubscription;

  Future<void> fetchCars() async {
    // Simulate initial load
    await Future.delayed(const Duration(seconds: 2));

    final initialData = [
      CarDto(
        carId: 1,
        manufacturer: 'Porsche',
        model: '911',
        price: 120000,
        isVerified: true,
        isHotPromotion: false,
      ),
      CarDto(
        carId: 2,
        manufacturer: 'Honda',
        model: 'Civic',
        price: 25000,
        isVerified: false,
        isHotPromotion: true,
      ),
    ];

    _carStreamController.add(initialData);

    // 2. Automatically start live updates after the first successful fetch
    _startHeartbeat();
  }

  void _startHeartbeat() {
    _liveUpdateSubscription?.cancel(); // Don't start duplicate timers

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
        carId: 1,
        manufacturer: 'Porsche',
        model: '911',
        price: 120000 + Random().nextInt(1000), // Randomize!
        distanceTo: Random().nextInt(60),
        isVerified: true,
        isHotPromotion: false,
      ),
      CarDto(
        carId: 2,
        manufacturer: 'Honda',
        model: 'Civic',
        price: 25000 + Random().nextInt(500), // Randomize!
        distanceTo: Random().nextInt(50),
        isVerified: false,
        isHotPromotion: true,
      ),
    ];
  }

  void dispose() {
    _liveUpdateSubscription?.cancel();
    _carStreamController.close();
  }
}
