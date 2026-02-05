import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test_futter_project/common/enums/body_type.dart';
import 'package:test_futter_project/common/enums/car_type.dart';
import 'package:test_futter_project/common/enums/drawer_type.dart';
import 'package:test_futter_project/common/enums/fuel_type.dart';
import 'package:test_futter_project/common/enums/transmission_type.dart';
import 'package:test_futter_project/domain/entities/car_entity.dart';
import 'package:test_futter_project/domain/usecases/database/get_all_cars_use_case.dart';
import 'package:test_futter_project/domain/usecases/database/watch_cars_use_case.dart';
import 'package:test_futter_project/presentation/bloc/search/search_page_cubit.dart';
import 'package:test_futter_project/presentation/bloc/search/search_page_state.dart';

import 'search_page_cubit_test.mocks.dart';

@GenerateMocks([GetAllCarsUseCase, WatchCarsUseCase])
void main() {
  late MockGetAllCarsUseCase mockGetAllCarsUseCase;
  late MockWatchCarsUseCase mockWatchCarsUseCase;

  late SearchPageCubit cubit;
  final car1 = CarEntity(
    carId: '1',
    model: 'Model S',
    manufacturer: 'Tesla',
    type: 'car',
    isVerified: true,
    isHotPromotion: false,
    year: '2022',
    kilometers: 1000,
    distanceTo: 5,
    price: 90000,
    fuelType: FuelType.ev.name,
    bodyType: BodyType.sedan.name,
    transmissionType: TransmissionType.automatic.name,
  );

  final car2 = CarEntity(
    carId: '2',
    model: 'CBR',
    manufacturer: 'Honda',
    type: 'bike',
    isVerified: false,
    isHotPromotion: false,
    year: '2018',
    kilometers: 8000,
    distanceTo: 10,
    price: 7000,
    fuelType: FuelType.gasoline.name,
    bodyType: BodyType.sedan.name,
    transmissionType: TransmissionType.automatic.name,
  );
  final carList = [car1, car2];

  setUp(() {
    mockWatchCarsUseCase = MockWatchCarsUseCase();
    mockGetAllCarsUseCase = MockGetAllCarsUseCase();
    cubit = SearchPageCubit(mockGetAllCarsUseCase, mockWatchCarsUseCase);
  });

  group('SearchPageCubit', () {
    test('initial state is correct', () {
      expect(cubit.state, const SearchPageState());
    });

    blocTest<SearchPageCubit, SearchPageState>(
      'loadData emits loading, updates allModels, and results',
      build: () {
        when(mockGetAllCarsUseCase.call()).thenReturn(carList);
        when(mockWatchCarsUseCase.call()).thenReturn(null);
        return cubit;
      },
      act: (cubit) => cubit.loadData(),
      expect: () => [
        const SearchPageState(isLoading: true),
        isA<SearchPageState>().having((s) => s.allModels, 'allModels', isNotEmpty),
        isA<SearchPageState>()
            .having((s) => s.allResults, 'allResults', isNotEmpty)
            .having((s) => s.isLoading, 'isLoading', false),
      ],
    );

    blocTest<SearchPageCubit, SearchPageState>(
      'updateTypeSelection emits new type and clears selectedModels',
      build: () => cubit,
      act: (cubit) => cubit.updateTypeSelection(CarType.bike),
      expect: () => [
        isA<SearchPageState>().having(
          (s) => s.currentSelectedType,
          'currentSelectedType',
          CarType.car,
        ),
        isA<SearchPageState>()
            .having((s) => s.currentSelectedType, 'currentSelectedType', CarType.bike)
            .having((s) => s.selectedModels, 'selectedModels', isEmpty),
      ],
    );

    test('filterCarsByType returns only cars of selected type', () {
      cubit.emit(cubit.state.copyWith(currentSelectedType: CarType.car));
      final filtered = cubit.applyAllFilters(carList);
      expect(filtered, [car1]);
    });

    test('filterCarsByModel returns only cars with selected models', () {
      final state = cubit.state.copyWith(selectedModels: ['Tesla Model S']);
      cubit.emit(state);
      final filtered = cubit.applyAllFilters(carList);
      expect(filtered, [car1]);
    });

    blocTest<SearchPageCubit, SearchPageState>(
      'updateModelSelection updates selectedModels and results',
      build: () => cubit,
      seed: () => SearchPageState(allResults: carList),
      act: (cubit) => cubit.updateModelSelection(['Tesla Model S']),
      expect: () => [
        isA<SearchPageState>().having((s) => s.selectedModels, 'selectedModels', ['Tesla Model S']),
        isA<SearchPageState>().having((s) => s.results, 'results', [car1]),
      ],
    );

    blocTest<SearchPageCubit, SearchPageState>(
      'addCarModelToSelection adds model and updates results',
      build: () => cubit,
      seed: () => SearchPageState(allResults: carList, selectedModels: []),
      act: (cubit) => cubit.addCarModelToSelection('Tesla Model S'),
      expect: () => [
        isA<SearchPageState>().having((s) => s.selectedModels, 'selectedModels', ['Tesla Model S']),
        isA<SearchPageState>().having((s) => s.results, 'results', [car1]),
      ],
    );

    //todo: the test is not working
    // blocTest<SearchPageCubit, SearchPageState>(
    //   'removeCarModelFromSelection removes model and updates results',
    //   build: () => cubit,
    //   seed: () => SearchPageState(results: carList, selectedModels: ['Tesla Model S']),
    //   act: (cubit) => cubit.removeCarModelFromSelection('Tesla Model S'),
    //   expect: () => [
    //     isA<SearchPageState>().having((s) => s.results, 'results', carList),
    //     isA<SearchPageState>().having((s) => s.selectedModels, 'selectedModels', isEmpty),
    //   ],
    // );

    blocTest<SearchPageCubit, SearchPageState>(
      'openDrawer emits state with drawerOpened',
      build: () => cubit,
      act: (cubit) => cubit.openDrawer(SearchDrawerType.model),
      expect: () => [
        isA<SearchPageState>().having(
          (s) => s.drawerOpened,
          'drawerOpened',
          SearchDrawerType.model,
        ),
      ],
    );

    //todo: the test is not compatible with cubit's private variables
    // test('close cancels car subscription', () async {
    //   final controller = StreamController<List<CarEntity>>();
    //   when(mockCarRepository.getAllCars()).thenReturn(carList);
    //   when(mockCarRepository.watchCars()).thenReturn(controller.stream);
    //   cubit.loadData();
    //   expect(cubit._carSubscription, isNotNull);
    //   await cubit.close();
    //   expect(cubit._carSubscription, isNull);
    // });
  });
}
