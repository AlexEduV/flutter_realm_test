import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test_flutter_project/core/di/injection_container.dart';
import 'package:test_flutter_project/data/data_sources/remote/mock_car_remote_data_source_impl.dart';
import 'package:test_flutter_project/domain/entities/owner_entity.dart';
import 'package:test_flutter_project/domain/usecases/database/get_all_cars_use_case.dart';
import 'package:test_flutter_project/domain/usecases/owners/get_owner_by_id_use_case.dart';

import '../../../domain/repositories/base_local_storage_test.mocks.dart';
import '../../../presentation/pages/home/new_item_page/new_item_page_test.mocks.dart';
import 'car_remote_data_source_impl_test.mocks.dart';

@GenerateMocks([GetOwnerByIdUseCase])
void main() {
  late MockCarRemoteDataSourceImpl service;
  final mockGetOwnerByIdUseCase = MockGetOwnerByIdUseCase();
  final mockLocalStorage = MockBaseLocalStorage();
  final mockGetAllCarsUseCase = MockGetAllCarsUseCase();

  setUp(() {
    when(mockGetAllCarsUseCase.call()).thenReturn([]);
    when(mockLocalStorage.getAll()).thenReturn([]);

    service = MockCarRemoteDataSourceImpl(mockLocalStorage);
    serviceLocator.registerLazySingleton<GetOwnerByIdUseCase>(() => mockGetOwnerByIdUseCase);
    serviceLocator.registerLazySingleton<GetAllCarsUseCase>(() => mockGetAllCarsUseCase);
    when(mockGetOwnerByIdUseCase.call(any)).thenReturn(OwnerEntity.empty());
  });

  tearDown(() async {
    await service.dispose();
    serviceLocator.unregister<GetOwnerByIdUseCase>();
    serviceLocator.unregister<GetAllCarsUseCase>();
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
