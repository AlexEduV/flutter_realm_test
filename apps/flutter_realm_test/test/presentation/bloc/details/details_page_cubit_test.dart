import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test_flutter_project/domain/entities/car_entity.dart';
import 'package:test_flutter_project/domain/usecases/database/get_car_by_id_use_case.dart';
import 'package:test_flutter_project/presentation/bloc/details/details_page_cubit.dart';
import 'package:test_flutter_project/presentation/bloc/details/details_page_state.dart';

import 'details_page_cubit_test.mocks.dart';

@GenerateMocks([GetCarByIdUseCase])
void main() {
  late MockGetCarByIdUseCase mockGetCarByIdUseCase;
  late DetailsPageCubit cubit;

  setUp(() {
    mockGetCarByIdUseCase = MockGetCarByIdUseCase();
    cubit = DetailsPageCubit(mockGetCarByIdUseCase);
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
  });
}
