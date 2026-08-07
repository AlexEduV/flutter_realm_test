import 'dart:ui';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test_flutter_project/domain/entities/car_entity.dart';
import 'package:test_flutter_project/domain/usecases/database/get_car_by_id_use_case.dart';
import 'package:test_flutter_project/presentation/features/details/details_page_cubit.dart';
import 'package:test_flutter_project/presentation/features/details/details_page_state.dart';

import '../../pages/details/widgets/owner_widget_test.mocks.dart';
import '../../pages/details/widgets/vehicle_specs_widget_test.mocks.dart';
import 'details_page_cubit_test.mocks.dart';

@GenerateNiceMocks([MockSpec<GetCarByIdUseCase>()])
void main() {
  late MockGetCarByIdUseCase mockGetCarByIdUseCase;
  late MockGetCarColorsUseCase mockGetCarColorsUseCase;
  late MockGetConversationByOwnerIdUseCase mockGetConversationByOwnerIdUseCase;
  late DetailsPageCubit cubit;

  setUp(() {
    mockGetCarByIdUseCase = MockGetCarByIdUseCase();
    mockGetCarColorsUseCase = MockGetCarColorsUseCase();
    mockGetConversationByOwnerIdUseCase = MockGetConversationByOwnerIdUseCase();
    cubit = DetailsPageCubit(
      mockGetCarByIdUseCase,
      mockGetCarColorsUseCase,
      mockGetConversationByOwnerIdUseCase,
    );
  });

  group('DetailsPageCubit', () {
    test('initial state is correct', () {
      expect(cubit.state, const DetailsPageState());
    });

    blocTest<DetailsPageCubit, DetailsPageState>(
      'loadData emits state with car entity',
      build: () {
        final car = CarEntity.empty().copyWith(carId: '123', model: 'Test Car');
        when(mockGetCarByIdUseCase.call('123')).thenReturn(car);
        when(mockGetCarColorsUseCase.call()).thenReturn({});
        return cubit;
      },
      act: (cubit) => cubit.loadData('123'),
      expect: () => [
        cubit.state.copyWith(
          car: CarEntity.empty().copyWith(carId: '123', model: 'Test Car'),
        ),
      ],
      verify: (_) {
        verify(mockGetCarByIdUseCase.call('123')).called(1);
      },
    );

    blocTest<DetailsPageCubit, DetailsPageState>(
      'setVehicleSpecsExpansionState emits state with updated expansion',
      build: () => cubit,
      act: (cubit) => cubit.setVehicleSpecsExpansionState(true),
      expect: () => [cubit.state.copyWith(isVehicleSpecsExpanded: true)],
    );

    // Guards the contract between how color names are stored (title case, e.g. 'Light Blue')
    // and how the cubit resolves them against the camelCase color map keys ('lightBlue').
    // If either side changes its format, this test will fail.
    blocTest<DetailsPageCubit, DetailsPageState>(
      'loadData resolves title-case color name to the correct Color',
      build: () {
        const lightBlue = Color(0xFF03A9F4);
        final car = CarEntity.empty().copyWith(carId: '1', color: 'Light Blue');
        when(mockGetCarByIdUseCase.call('1')).thenReturn(car);
        when(mockGetCarColorsUseCase.call()).thenReturn({'lightBlue': lightBlue});
        return cubit;
      },
      act: (cubit) => cubit.loadData('1'),
      expect: () => [
        isA<DetailsPageState>().having((s) => s.carColor, 'carColor', const Color(0xFF03A9F4)),
      ],
    );
  });
}
