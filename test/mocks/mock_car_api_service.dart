import 'dart:math';

import 'package:rxdart/rxdart.dart';
import 'package:test_futter_project/data/dto/car_dto.dart';

class MockCarApiService {
  final List<Map<String, dynamic>> _rawMockData = [
    {'id': 1, 'model': '911', 'manufacturer': 'Porsche', 'is_verified': true, 'price': 120000},
    {'id': 2, 'model': 'Civic', 'manufacturer': 'Honda', 'is_verified': false, 'price': 25000},
  ];

  final _carStreamController = BehaviorSubject<List<CarDto>>();

  Stream<List<CarDto>> get carStream => _carStreamController.stream;

  Future<void> fetchCars() async {
    await Future.delayed(Duration(seconds: 2));

    final dtos = _rawMockData.map((json) => CarDto.fromJson(json)).toList();

    _carStreamController.add(dtos);
  }

  Stream<List<CarDto>> getLiveCarUpdates() {
    return Stream.periodic(const Duration(seconds: 5)).asyncMap((_) async {
      // Simulate network delay for the request
      await Future.delayed(const Duration(milliseconds: 500));

      // Return fresh DTOs with randomized price/distance
      return [
        CarDto(
          carId: 1,
          manufacturer: 'Tesla',
          model: 'Model Y',
          price: 120000 + Random().nextInt(1000),
          distanceTo: Random().nextInt(60),
          isVerified: false,
          isHotPromotion: false,
          year: '2018',
        ),

        CarDto(
          carId: 2,
          manufacturer: 'Honda',
          model: 'Civic',
          price: 120000 + Random().nextInt(1000),
          distanceTo: Random().nextInt(50),
          isVerified: true,
          isHotPromotion: true,
          year: '2010',
        ),
      ];
    });
  }

  void dispose() => _carStreamController.close();
}
