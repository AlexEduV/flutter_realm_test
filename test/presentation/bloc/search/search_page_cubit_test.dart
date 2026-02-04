import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:test_futter_project/common/enums/car_type.dart';
import 'package:test_futter_project/common/enums/drawer_type.dart';
import 'package:test_futter_project/domain/entities/car_entity.dart';
import 'package:test_futter_project/presentation/bloc/search/search_page_cubit.dart';
import 'package:test_futter_project/presentation/bloc/search/search_page_state.dart';

import '../../../domain/repositories/car_repository_test.mocks.dart';

void main() {
  late MockCarRepository mockCarRepository;
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
  );
  final carList = [car1, car2];

  setUp(() {
    mockCarRepository = MockCarRepository();
    cubit = SearchPageCubit(mockCarRepository);
  });

  group('SearchPageCubit', () {
    test('initial state is correct', () {
      expect(cubit.state, const SearchPageState());
    });

    blocTest<SearchPageCubit, SearchPageState>(
      'loadData emits loading, updates allModels, and results',
      build: () {
        when(mockCarRepository.getAllCars()).thenReturn(carList);
        when(mockCarRepository.watchCars()).thenReturn(null);
        return cubit;
      },
      act: (cubit) => cubit.loadData(),
      expect: () => [
        const SearchPageState(isLoading: true),
        isA<SearchPageState>().having((s) => s.allModels, 'allModels', isNotEmpty),
        isA<SearchPageState>()
            .having((s) => s.results, 'results', isNotEmpty)
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
      final filtered = cubit.filterCarsByType(carList);
      expect(filtered, [car1]);
    });

    test('filterCarsByModel returns only cars with selected models', () {
      final state = cubit.state.copyWith(selectedModels: ['Tesla Model S']);
      cubit.emit(state);
      final filtered = cubit.filterCarsByModel(carList);
      expect(filtered, [car1]);
    });

    blocTest<SearchPageCubit, SearchPageState>(
      'updateModelSelection updates selectedModels and results',
      build: () => cubit,
      seed: () => SearchPageState(results: carList),
      act: (cubit) => cubit.updateModelSelection(['Tesla Model S']),
      expect: () => [
        isA<SearchPageState>().having((s) => s.selectedModels, 'selectedModels', ['Tesla Model S']),
        isA<SearchPageState>().having((s) => s.results, 'results', [car1]),
      ],
    );

    blocTest<SearchPageCubit, SearchPageState>(
      'addCarModelToSelection adds model and updates results',
      build: () => cubit,
      seed: () => SearchPageState(results: carList, selectedModels: []),
      act: (cubit) => cubit.addCarModelToSelection('Tesla Model S'),
      expect: () => [
        isA<SearchPageState>().having((s) => s.selectedModels, 'selectedModels', ['Tesla Model S']),
        isA<SearchPageState>().having((s) => s.results, 'results', [car1]),
      ],
    );

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
