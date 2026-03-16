import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test_futter_project/data/data_sources/remote/mock_car_remote_data_source_impl.dart';
import 'package:test_futter_project/di/injection_container.dart';
import 'package:test_futter_project/domain/entities/owner_entity.dart';
import 'package:test_futter_project/domain/usecases/owners/get_owner_by_id_use_case.dart';

import 'car_remote_data_source_impl_test.mocks.dart';

@GenerateMocks([GetOwnerByIdUseCase])
void main() {
  late MockCarRemoteDataSourceImpl service;
  final mockGetOwnerByIdUseCase = MockGetOwnerByIdUseCase();

  setUp(() {
    service = MockCarRemoteDataSourceImpl();
    serviceLocator.registerLazySingleton<GetOwnerByIdUseCase>(() => mockGetOwnerByIdUseCase);
    when(mockGetOwnerByIdUseCase.call(any)).thenReturn(OwnerEntity.empty());
  });

  tearDown(() async {
    await service.dispose();
    serviceLocator.unregister<GetOwnerByIdUseCase>();
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
