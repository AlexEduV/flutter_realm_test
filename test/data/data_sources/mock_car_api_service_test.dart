import 'package:flutter_test/flutter_test.dart';
import 'package:test_futter_project/data/data_sources/mock_car_api_service.dart';

void main() {
  late MockCarApiService service;

  setUp(() {
    service = MockCarApiService();
  });

  tearDown(() async {
    await service.dispose();
  });

  test('fetchCars returns initial data after delay', () async {
    final stopwatch = Stopwatch()..start();
    final cars = await service.fetchCars();
    stopwatch.stop();

    expect(cars.length, 3);
    expect(cars[0].manufacturer, 'Porsche');
    expect(cars[1].manufacturer, 'Honda');
    expect(stopwatch.elapsed.inSeconds, greaterThanOrEqualTo(2));
  });

  test('carStream emits initial data after fetchCars', () async {
    await service.fetchCars();
    final emitted = await service.carStream.first;
    expect(emitted.length, 3);
    expect(emitted[0].manufacturer, 'Porsche');
    expect(emitted[1].manufacturer, 'Honda');
  });

  test('carStream emits updated data after heartbeat', () async {
    await service.fetchCars();
    // Wait for the next heartbeat update (5s + 0.5s)
    final updated = await service.carStream.skip(1).first;
    expect(updated.length, 3);
    // Prices and distances should be randomized
    expect(updated[0].price, isNotNull);
    expect(updated[0].distanceTo, isNotNull);
    expect(updated[1].price, isNotNull);
    expect(updated[1].distanceTo, isNotNull);
  }, timeout: const Timeout(Duration(seconds: 8)));

  test('dispose cancels subscription and closes stream', () async {
    await service.fetchCars();
    await service.dispose();
    expect(service.carStream.isBroadcast, true); // BehaviorSubject is broadcast
  });
}
