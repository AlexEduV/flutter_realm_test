import 'dart:async';

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
import 'package:test_futter_project/domain/models/field_params_model.dart';
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

  final car3 = CarEntity(
    carId: '3',
    model: 'Civic',
    manufacturer: 'Honda',
    type: 'car',
    isVerified: false,
    isHotPromotion: false,
    year: '2008',
    kilometers: 10000,
    distanceTo: 10,
    price: 13000,
    fuelType: FuelType.hybrid.name,
    bodyType: BodyType.sedan.name,
    transmissionType: TransmissionType.automatic.name,
  );

  final carList = [car1, car2, car3];

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
      'init emits field params and calls loadData',
      build: () {
        when(mockGetAllCarsUseCase.call()).thenReturn(carList);
        when(mockWatchCarsUseCase.call()).thenReturn(null);
        return cubit;
      },
      act: (cubit) => cubit.init(),
      expect: () => [
        isA<SearchPageState>()
            .having(
              (s) => s.minYearFieldParamsModel?.label,
              'minYearFieldParamsModel.label',
              'Min:',
            )
            .having(
              (s) => s.maxYearFieldParamsModel?.label,
              'maxYearFieldParamsModel.label',
              'Max:',
            )
            .having(
              (s) => s.minPriceFieldParamsModel?.label,
              'minPriceFieldParamsModel.label',
              'Min:',
            )
            .having(
              (s) => s.maxPriceFieldParamsModel?.label,
              'maxPriceFieldParamsModel.label',
              'Max:',
            ),
        isA<SearchPageState>().having((s) => s.isLoading, 'isLoading', true),
        isA<SearchPageState>().having((s) => s.allModels, 'allModels', isNotEmpty),
        isA<SearchPageState>()
            .having((s) => s.allResults, 'allResults', isNotEmpty)
            .having((s) => s.isLoading, 'isLoading', false),
      ],
    );

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
      'updateTypeSelection emits new type and clears selectedModels/bodyTypes',
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
            .having((s) => s.selectedModels, 'selectedModels', isEmpty)
            .having((s) => s.selectedBodyTypes, 'selectedBodyTypes', isEmpty),
      ],
    );

    test('applyAllFilters returns only cars of selected type', () {
      cubit.emit(cubit.state.copyWith(currentSelectedType: CarType.car));
      final filtered = cubit.applyAllFilters(carList);
      expect(filtered, [car1, car3]);
    });

    test('applyAllFilters returns only cars with selected models', () {
      final state = cubit.state.copyWith(selectedModels: ['Tesla Model S']);
      cubit.emit(state);
      final filtered = cubit.applyAllFilters(carList);
      expect(filtered, [car1]);
    });

    test('applyAllFilters returns only cars with selected body types', () {
      final state = cubit.state.copyWith(selectedBodyTypes: [BodyType.sedan.name]);
      cubit.emit(state);
      final filtered = cubit.applyAllFilters(carList);
      expect(filtered, [car1, car3]);
    });

    test('applyAllFilters returns only cars with selected fuel types', () {
      final state = cubit.state.copyWith(selectedFuelTypes: [FuelType.ev.name]);
      cubit.emit(state);
      final filtered = cubit.applyAllFilters(carList);
      expect(filtered, [car1]);
    });

    test('applyAllFilters returns only cars with selected transmission types', () {
      final state = cubit.state.copyWith(
        currentSelectedType: CarType.car,
        selectedTransmissionTypes: [TransmissionType.automatic.name],
      );
      cubit.emit(state);
      final filtered = cubit.applyAllFilters(carList);
      expect(filtered, [car1, car3]);
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

    blocTest<SearchPageCubit, SearchPageState>(
      'removeCarModelFromSelection removes model and updates results',
      build: () => cubit,
      seed: () => SearchPageState(allResults: carList, selectedModels: ['Tesla Model S']),
      act: (cubit) => cubit.removeCarModelFromSelection('Tesla Model S'),
      expect: () => [
        isA<SearchPageState>().having((s) => s.selectedModels, 'selectedModels', isEmpty),
        isA<SearchPageState>().having((s) => s.results, 'results', [car1, car3]),
      ],
    );

    blocTest<SearchPageCubit, SearchPageState>(
      'addBodyTypeToSelection adds body type and updates results',
      build: () => cubit,
      seed: () => SearchPageState(allResults: carList, selectedBodyTypes: []),
      act: (cubit) => cubit.addBodyTypeToSelection(BodyType.sedan.name),
      expect: () => [
        isA<SearchPageState>().having((s) => s.selectedBodyTypes, 'selectedBodyTypes', [
          BodyType.sedan.name,
        ]),
        isA<SearchPageState>().having((s) => s.results, 'results', [car1, car3]),
      ],
    );

    blocTest<SearchPageCubit, SearchPageState>(
      'removeBodyTypeFromSelection removes body type and updates results',
      build: () => cubit,
      seed: () => SearchPageState(allResults: carList, selectedBodyTypes: [BodyType.sedan.name]),
      act: (cubit) => cubit.removeBodyTypeFromSelection(BodyType.sedan.name),
      expect: () => [
        isA<SearchPageState>().having((s) => s.selectedBodyTypes, 'selectedBodyTypes', isEmpty),
        isA<SearchPageState>().having((s) => s.results, 'results', [car1, car3]),
      ],
    );

    blocTest<SearchPageCubit, SearchPageState>(
      'addFuelTypeToSelection adds fuel type and updates results',
      build: () => cubit,
      seed: () => SearchPageState(allResults: carList, selectedFuelTypes: []),
      act: (cubit) => cubit.addFuelTypeToSelection(FuelType.ev.name),
      expect: () => [
        isA<SearchPageState>().having((s) => s.selectedFuelTypes, 'selectedFuelTypes', [
          FuelType.ev.name,
        ]),
        isA<SearchPageState>().having((s) => s.results, 'results', [car1]),
      ],
    );

    blocTest<SearchPageCubit, SearchPageState>(
      'removeFuelTypeFromSelection removes fuel type and updates results',
      build: () => cubit,
      seed: () => SearchPageState(allResults: carList, selectedFuelTypes: [FuelType.ev.name]),
      act: (cubit) => cubit.removeFuelTypeFromSelection(FuelType.ev.name),
      expect: () => [
        isA<SearchPageState>().having((s) => s.selectedFuelTypes, 'selectedFuelTypes', isEmpty),
        isA<SearchPageState>().having((s) => s.results, 'results', [car1, car3]),
      ],
    );

    blocTest<SearchPageCubit, SearchPageState>(
      'addTransmissionTypeToSelection adds transmission type and updates results',
      build: () => cubit,
      seed: () => SearchPageState(allResults: carList, selectedTransmissionTypes: []),
      act: (cubit) => cubit.addTransmissionTypeToSelection(TransmissionType.automatic.name),
      expect: () => [
        isA<SearchPageState>().having(
          (s) => s.selectedTransmissionTypes,
          'selectedTransmissionTypes',
          [TransmissionType.automatic.name],
        ),
        isA<SearchPageState>().having((s) => s.results, 'results', [car1, car3]),
      ],
    );

    blocTest<SearchPageCubit, SearchPageState>(
      'removeTransmissionTypeFromSelection removes transmission type and updates results',
      build: () => cubit,
      seed: () => SearchPageState(
        allResults: carList,
        selectedTransmissionTypes: [TransmissionType.automatic.name],
      ),
      act: (cubit) => cubit.removeTransmissionTypeFromSelection(TransmissionType.automatic.name),
      expect: () => [
        isA<SearchPageState>().having(
          (s) => s.selectedTransmissionTypes,
          'selectedTransmissionTypes',
          isEmpty,
        ),
        isA<SearchPageState>().having((s) => s.results, 'results', [car1, car3]),
      ],
    );

    blocTest<SearchPageCubit, SearchPageState>(
      'updateSelectedMinYear emits new min year and validates',
      build: () => cubit,
      act: (cubit) => cubit.updateSelectedMinYear('2020'),
      expect: () => [
        isA<SearchPageState>()
            .having((s) => s.selectedMinYear, 'selectedMinYear', '2020')
            .having((s) => s.minYearError, 'minYearError', null),
      ],
    );

    blocTest<SearchPageCubit, SearchPageState>(
      'updateSelectedMaxYear emits new max year and validates',
      build: () => cubit,
      act: (cubit) => cubit.updateSelectedMaxYear('2022'),
      expect: () => [
        isA<SearchPageState>()
            .having((s) => s.selectedMaxYear, 'selectedMaxYear', '2022')
            .having((s) => s.maxYearError, 'maxYearError', null),
      ],
    );

    blocTest<SearchPageCubit, SearchPageState>(
      'updateSelectedMinPrice emits new min price and validates',
      build: () => cubit,
      act: (cubit) => cubit.updateSelectedMinPrice('10000'),
      expect: () => [
        isA<SearchPageState>()
            .having((s) => s.selectedMinPrice, 'selectedMinPrice', '10000')
            .having((s) => s.minPriceError, 'minPriceError', null),
      ],
    );

    blocTest<SearchPageCubit, SearchPageState>(
      'updateSelectedMaxPrice emits new max price and validates',
      build: () => cubit,
      act: (cubit) => cubit.updateSelectedMaxPrice('20000'),
      expect: () => [
        isA<SearchPageState>()
            .having((s) => s.selectedMaxPrice, 'selectedMaxPrice', '20000')
            .having((s) => s.maxPriceError, 'maxPriceError', null),
      ],
    );

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

    test('validateYears returns false and emits errors if minYear > maxYear', () {
      final minYearModel = FieldParamsModel.withLabel(
        'Min:',
      ).copyWith(validationMessage: 'Incorrect value');
      final maxYearModel = FieldParamsModel.withLabel(
        'Max:',
      ).copyWith(validationMessage: 'Incorrect value');
      cubit.emit(
        cubit.state.copyWith(
          minYearFieldParamsModel: minYearModel,
          maxYearFieldParamsModel: maxYearModel,
        ),
      );
      final result = cubit.validateYears('2022', '2020');
      expect(result, false);
      expect(cubit.state.minYearError, 'Incorrect value');
      expect(cubit.state.maxYearError, 'Incorrect value');
    });

    test('validateYears returns true and clears errors if minYear <= maxYear', () {
      final minYearModel = FieldParamsModel.withLabel(
        'Min:',
      ).copyWith(validationMessage: 'Incorrect value');
      final maxYearModel = FieldParamsModel.withLabel(
        'Max:',
      ).copyWith(validationMessage: 'Incorrect value');
      cubit.emit(
        cubit.state.copyWith(
          minYearFieldParamsModel: minYearModel,
          maxYearFieldParamsModel: maxYearModel,
        ),
      );
      final result = cubit.validateYears('2020', '2022');
      expect(result, true);
      expect(cubit.state.minYearError, null);
      expect(cubit.state.maxYearError, null);
    });

    test('validatePrices returns false and emits errors if minPrice > maxPrice', () {
      final minPriceModel = FieldParamsModel.withLabel(
        'Min:',
      ).copyWith(validationMessage: 'Incorrect value');
      final maxPriceModel = FieldParamsModel.withLabel(
        'Max:',
      ).copyWith(validationMessage: 'Incorrect value');
      cubit.emit(
        cubit.state.copyWith(
          minPriceFieldParamsModel: minPriceModel,
          maxPriceFieldParamsModel: maxPriceModel,
        ),
      );
      final result = cubit.validatePrices('20000', '10000');
      expect(result, false);
      expect(cubit.state.minPriceError, 'Incorrect value');
      expect(cubit.state.maxPriceError, 'Incorrect value');
    });

    test('validatePrices returns true and clears errors if minPrice <= maxPrice', () {
      final minPriceModel = FieldParamsModel.withLabel(
        'Min:',
      ).copyWith(validationMessage: 'Incorrect value');
      final maxPriceModel = FieldParamsModel.withLabel(
        'Max:',
      ).copyWith(validationMessage: 'Incorrect value');
      cubit.emit(
        cubit.state.copyWith(
          minPriceFieldParamsModel: minPriceModel,
          maxPriceFieldParamsModel: maxPriceModel,
        ),
      );
      final result = cubit.validatePrices('10000', '20000');
      expect(result, true);
      expect(cubit.state.minPriceError, null);
      expect(cubit.state.maxPriceError, null);
    });

    test('close cancels car subscription', () async {
      final controller = StreamController<List<CarEntity>>();
      when(mockGetAllCarsUseCase.call()).thenReturn(carList);
      when(mockWatchCarsUseCase.call()).thenAnswer((_) => controller.stream);
      cubit.loadData();
      expect(cubit.close(), completes);
    });
  });
}
