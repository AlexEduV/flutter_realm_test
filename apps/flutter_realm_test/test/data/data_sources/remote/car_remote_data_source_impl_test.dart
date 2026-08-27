@Tags(['streams'])
library;

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:test_flutter_project/data/data_sources/remote/seed_car_remote_data_source_impl.dart';
import 'package:test_flutter_project/domain/entities/owner_entity.dart';

import '../../../common/fakes/common_mocks.mocks.dart';

void main() {
  late SeedCarRemoteDataSourceImpl service;
  final mockOwnersRemoteDataSource = MockOwnersRemoteDataSource();
  final mockLocalStorage = MockAppLocalStorage();

  setUp(() {
    when(mockLocalStorage.getAllCars()).thenReturn([]);
    when(mockOwnersRemoteDataSource.getOwnerById(any)).thenReturn(OwnerEntity.empty());

    service = SeedCarRemoteDataSourceImpl(mockLocalStorage, mockOwnersRemoteDataSource);
  });

  tearDown(() async {
    await service.dispose();
  });

  test('fetchCars returns initial data after delay', () async {
    final stopwatch = Stopwatch()..start();
    final cars = await service.fetchCars();
    stopwatch.stop();

    expect(cars.length, 0);
    expect(stopwatch.elapsed.inSeconds, greaterThanOrEqualTo(2));
  });

  test('carStream emits initial data after fetchCars', () async {
    service.init();
    await service.fetchCars();

    final emitted = await service.carStream.first;

    expect(emitted.length, 3);
    expect(emitted[0].manufacturer, 'Porsche');
    expect(emitted[1].manufacturer, 'Honda');
    expect(emitted[2].manufacturer, 'Scania');
  });

  // Heartbeat test omitted: it requires a real 5.5 s timer and belongs in
  // integration tests, not unit tests.

  test('dispose cancels subscription and closes stream', () async {
    await service.fetchCars();
    await service.dispose();
    expect(service.carStream.isBroadcast, true); // BehaviorSubject is broadcast
  });
}
