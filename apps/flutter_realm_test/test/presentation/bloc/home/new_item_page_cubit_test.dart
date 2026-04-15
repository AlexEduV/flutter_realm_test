import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test_flutter_project/common/enums/body_type.dart';
import 'package:test_flutter_project/common/enums/car_type.dart';
import 'package:test_flutter_project/common/enums/fuel_type.dart';
import 'package:test_flutter_project/common/enums/transmission_type.dart';
import 'package:test_flutter_project/core/di/injection_container.dart';
import 'package:test_flutter_project/domain/entities/car_auto_complete_entity.dart';
import 'package:test_flutter_project/domain/models/field_params_model.dart';
import 'package:test_flutter_project/domain/usecases/auto_complete/get_auto_complete_manufacturers_by_type_use_case.dart';
import 'package:test_flutter_project/presentation/bloc/home/new_item_page/new_item_page_cubit.dart';
import 'package:test_flutter_project/presentation/bloc/home/new_item_page/new_item_page_state.dart';
import 'package:test_flutter_project/presentation/bloc/l10n/app_localisations_cubit.dart';

import '../../../common/extensions/context_extension_test.mocks.dart';
import 'new_item_page_cubit_test.mocks.dart';

@GenerateMocks([GetAutoCompleteManufacturersByTypeUseCase])
void main() {
  late MockGetAutoCompleteManufacturersByTypeUseCase mockAutoCompleteUseCase;
  late MockAppLocalisationsCubit mockLocalisationsCubit;
  late NewItemPageCubit cubit;

  setUp(() {
    mockAutoCompleteUseCase = MockGetAutoCompleteManufacturersByTypeUseCase();
    mockLocalisationsCubit = MockAppLocalisationsCubit();

    serviceLocator.registerSingleton<AppLocalisationsCubit>(mockLocalisationsCubit);

    // Mock localisations
    when(mockLocalisationsCubit.getLocalisationByKey(any)).thenReturn('label');

    cubit = NewItemPageCubit(mockAutoCompleteUseCase);
  });

  tearDown(() {
    serviceLocator.unregister<AppLocalisationsCubit>();
  });

  group('init', () {
    blocTest<NewItemPageCubit, NewItemPageState>(
      'emits state with initialized field params',
      build: () => cubit,
      act: (cubit) => cubit.init(),
      expect: () => [
        isA<NewItemPageState>()
            .having(
              (s) => s.manufacturerFieldParams,
              'manufacturerFieldParams',
              isA<FieldParamsModel>(),
            )
            .having((s) => s.modelFieldParams, 'modelFieldParams', isA<FieldParamsModel>())
            .having((s) => s.yearFieldParams, 'yearFieldParams', isA<FieldParamsModel>())
            .having((s) => s.priceFieldParams, 'priceFieldParams', isA<FieldParamsModel>())
            .having((s) => s.colorFieldParams, 'colorFieldParams', isA<FieldParamsModel>()),
      ],
    );
  });

  group('validation', () {
    setUp(() {
      cubit.emit(
        cubit.state.copyWith(
          manufacturerFieldParams: FieldParamsModel.withLabel('label').copyWith(
            validationMessage: 'required',
            regexErrorMessage: 'invalid',
            regex: r'^[A-Za-z\s\-]+$',
          ),
          modelFieldParams: FieldParamsModel.withLabel('label').copyWith(
            validationMessage: 'required',
            regexErrorMessage: 'invalid',
            regex: r'^[A-Za-z0-9\s\-\/\+]+$',
          ),
          yearFieldParams: FieldParamsModel.withLabel('label').copyWith(
            validationMessage: 'required',
            regexErrorMessage: 'invalid',
            regex: r'^(198[0-9]|199[0-9]|200[0-9]|201[0-9]|202[0-6])$',
          ),
          priceFieldParams: FieldParamsModel.withLabel('label').copyWith(
            validationMessage: 'required',
            regexErrorMessage: 'invalid',
            regex: r'^(0|[1-9]\d{0,7})$',
          ),
          colorFieldParams: FieldParamsModel.withLabel('label').copyWith(
            validationMessage: 'required',
            regexErrorMessage: 'invalid',
            regex: r'^[A-Za-z\s\-]+$',
          ),
        ),
      );
    });

    test('validateManufacturer returns true for valid input', () {
      expect(cubit.validateManufacturer('Toyota', false), isTrue);
      expect(cubit.state.manufacturerErrorText, isNull);
    });

    test('validateManufacturer returns false for empty input', () {
      expect(cubit.validateManufacturer('', false), isFalse);
      expect(cubit.state.manufacturerErrorText, 'required');
    });

    test('validateManufacturer returns false for invalid input', () {
      expect(cubit.validateManufacturer('123', false), isFalse);
      expect(cubit.state.manufacturerErrorText, 'invalid');
    });

    test('validateModel returns true for valid input', () {
      expect(cubit.validateModel('Corolla', false), isTrue);
      expect(cubit.state.modelErrorText, isNull);
    });

    test('validateYear returns true for valid input', () {
      expect(cubit.validateYear('2020', false), isTrue);
      expect(cubit.state.yearErrorText, isNull);
    });

    test('validatePrice returns true for valid input', () {
      expect(cubit.validatePrice('10000', false), isTrue);
      expect(cubit.state.priceErrorText, isNull);
    });

    test('validateColor returns true for valid input', () {
      expect(cubit.validateColor('Red', false), isTrue);
      expect(cubit.state.colorErrorText, isNull);
    });

    test('areAllFieldsValid returns true if all fields are valid', () {
      cubit.emit(
        cubit.state.copyWith(
          manufacturerText: 'Toyota',
          modelText: 'Corolla',
          yearText: '2020',
          priceText: '10000',
          colorText: 'Red',
        ),
      );
      expect(cubit.areAllFieldsValid(), isTrue);
    });

    test('areAllFieldsValid returns false if any field is invalid', () {
      cubit.emit(
        cubit.state.copyWith(
          manufacturerText: '',
          modelText: 'Corolla',
          yearText: '2020',
          priceText: '10000',
          colorText: 'Red',
        ),
      );
      expect(cubit.areAllFieldsValid(), isFalse);
    });
  });

  group('updates', () {
    blocTest<NewItemPageCubit, NewItemPageState>(
      'updateTabIndex emits updated state',
      build: () => cubit,
      act: (cubit) => cubit.updateTabIndex(2),
      expect: () => [cubit.state.copyWith(currentPageIndex: 2)],
    );

    blocTest<NewItemPageCubit, NewItemPageState>(
      'updateSelectedCarType emits updated state',
      build: () => cubit,
      act: (cubit) => cubit.updateSelectedCarType(CarType.truck),
      expect: () => [cubit.state.copyWith(selectedCarType: CarType.truck)],
    );

    blocTest<NewItemPageCubit, NewItemPageState>(
      'updateManufacturerText emits updated state',
      build: () => cubit,
      act: (cubit) => cubit.updateManufacturerText('Toyota'),
      expect: () => [cubit.state.copyWith(manufacturerText: 'Toyota')],
    );

    blocTest<NewItemPageCubit, NewItemPageState>(
      'updateModelText emits updated state',
      build: () => cubit,
      act: (cubit) => cubit.updateModelText('Corolla'),
      expect: () => [cubit.state.copyWith(modelText: 'Corolla')],
    );

    blocTest<NewItemPageCubit, NewItemPageState>(
      'updateYearText emits updated state',
      build: () => cubit,
      act: (cubit) => cubit.updateYearText('2020'),
      expect: () => [cubit.state.copyWith(yearText: '2020')],
    );

    blocTest<NewItemPageCubit, NewItemPageState>(
      'updatePriceText emits updated state',
      build: () => cubit,
      act: (cubit) => cubit.updatePriceText('10000'),
      expect: () => [cubit.state.copyWith(priceText: '10000')],
    );

    blocTest<NewItemPageCubit, NewItemPageState>(
      'updateColorText emits updated state',
      build: () => cubit,
      act: (cubit) => cubit.updateColorText('Red'),
      expect: () => [cubit.state.copyWith(colorText: 'Red')],
    );

    blocTest<NewItemPageCubit, NewItemPageState>(
      'updateSelectedBodyType emits updated state',
      build: () => cubit,
      act: (cubit) => cubit.updateSelectedBodyType(BodyType.minivan),
      expect: () => [cubit.state.copyWith(selectedBodyType: BodyType.minivan)],
    );

    blocTest<NewItemPageCubit, NewItemPageState>(
      'updateSelectedTransmissionType emits updated state',
      build: () => cubit,
      act: (cubit) => cubit.updateSelectedTransmissionType(TransmissionType.automatic),
      expect: () => [cubit.state.copyWith(selectedTransmissionType: TransmissionType.automatic)],
    );

    blocTest<NewItemPageCubit, NewItemPageState>(
      'updateSelectedFuelType emits updated state',
      build: () => cubit,
      act: (cubit) => cubit.updateSelectedFuelType(FuelType.hybrid),
      expect: () => [cubit.state.copyWith(selectedFuelType: FuelType.hybrid)],
    );

    blocTest<NewItemPageCubit, NewItemPageState>(
      'clearInfoForm emits state with cleared fields',
      build: () => cubit,
      act: (cubit) => cubit.clearInfoForm(),
      expect: () => [
        cubit.state.copyWith(
          manufacturerText: '',
          modelText: '',
          yearText: '',
          colorText: '',
          priceText: '',
        ),
      ],
    );
  });

  group('async and error clearing', () {
    final testAutoCompleteEntity = CarAutoCompleteEntity(
      manufacturerId: 1,
      manufacturer: 'Test',
      models: [],
    );

    blocTest<NewItemPageCubit, NewItemPageState>(
      'getAutoCompleteEntitiesByType emits state with autoCompleteEntities',
      build: () {
        when(
          mockAutoCompleteUseCase.call(CarType.car),
        ).thenAnswer((_) async => [testAutoCompleteEntity]);
        return cubit;
      },
      act: (cubit) => cubit.getAutoCompleteEntitiesByType(CarType.car),
      expect: () => [
        cubit.state.copyWith(autoCompleteEntities: [testAutoCompleteEntity]),
      ],
    );

    blocTest<NewItemPageCubit, NewItemPageState>(
      'clearFieldErrors emits state with all error texts null',
      build: () => cubit,
      act: (cubit) => cubit.clearFieldErrors(),
      expect: () => [
        cubit.state.copyWith(
          manufacturerErrorText: null,
          modelErrorText: null,
          yearErrorText: null,
          priceErrorText: null,
          colorErrorText: null,
        ),
      ],
    );
  });
}
