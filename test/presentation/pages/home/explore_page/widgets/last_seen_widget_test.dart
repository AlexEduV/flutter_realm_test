import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:test_futter_project/di/injection_container.dart';
import 'package:test_futter_project/domain/entities/car_entity.dart';
import 'package:test_futter_project/domain/usecases/database/get_car_by_id_use_case.dart';
import 'package:test_futter_project/presentation/bloc/home/explore_page/explore_page_cubit.dart';
import 'package:test_futter_project/presentation/bloc/home/explore_page/explore_page_state.dart';
import 'package:test_futter_project/presentation/bloc/l10n/app_localisations_cubit.dart';
import 'package:test_futter_project/presentation/bloc/user/user_data_cubit.dart';
import 'package:test_futter_project/presentation/bloc/user/user_data_state.dart';
import 'package:test_futter_project/presentation/pages/home/explore_page/widgets/last_seen_widget.dart';

import '../../../../../utils/app_router_test.mocks.dart';
import '../../../../bloc/details/details_page_cubit_test.mocks.dart';

void main() {
  late MockUserDataCubit mockUserDataCubit;
  late MockExplorePageCubit mockExplorePageCubit;
  late MockGetCarByIdUseCase mockGetCarByIdUseCase;
  final appLocalisationsCubit = AppLocalisationsCubit();

  final carEntity = CarEntity(
    carId: 'car124',
    manufacturer: 'Fiat',
    model: '500',
    year: '2020',
    price: 10000,
    images: [],
    isVerified: false,
    type: 'car',
    bodyType: 'sedan',
    fuelType: 'diesel',
    transmissionType: 'hybrid',
  );

  setUp(() {
    mockUserDataCubit = MockUserDataCubit();
    mockExplorePageCubit = MockExplorePageCubit();
    mockGetCarByIdUseCase = MockGetCarByIdUseCase();

    serviceLocator.registerSingleton<GetCarByIdUseCase>(mockGetCarByIdUseCase);

    when(mockGetCarByIdUseCase.call(any)).thenReturn(carEntity);
  });

  tearDown(() {
    serviceLocator.reset();
  });

  Widget buildTestWidget({
    required UserDataState userState,
    required ExplorePageState exploreState,
    required CarEntity carEntity,
  }) {
    // Mock the service locator
    // ignore: invalid_use_of_visible_for_testing_member
    // ignore: invalid_use_of_protected_member
    // You may need to adjust this depending on your DI setup
    // For example, if using get_it:
    // getIt.registerSingleton<GetCarByIdUseCase>(mockGetCarByIdUseCase);

    when(mockGetCarByIdUseCase.call(any)).thenReturn(carEntity);

    return MultiBlocProvider(
      providers: [
        BlocProvider<UserDataCubit>.value(value: mockUserDataCubit),
        BlocProvider<ExplorePageCubit>.value(value: mockExplorePageCubit),
        BlocProvider<AppLocalisationsCubit>.value(value: appLocalisationsCubit),
      ],
      child: const MaterialApp(home: Material(child: LastSeenWidget())),
    );
  }

  testWidgets('shows loading indicator when userState.isLoading is true', (tester) async {
    when(mockUserDataCubit.state).thenReturn(const UserDataState(isLoading: true));
    when(mockUserDataCubit.stream).thenAnswer((_) => const Stream.empty());

    await tester.pumpWidget(
      MultiBlocProvider(
        providers: [
          BlocProvider<UserDataCubit>.value(value: mockUserDataCubit),
          BlocProvider<ExplorePageCubit>.value(value: mockExplorePageCubit),
        ],
        child: const MaterialApp(home: LastSeenWidget()),
      ),
    );

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('shows car info when userState is loaded', (tester) async {
    final carId = 'car124';

    final userState = UserDataState(isLoading: false, lastSeenCar: {DateTime.now(): carId});
    final exploreState = const ExplorePageState();

    when(mockUserDataCubit.state).thenReturn(userState);
    when(mockUserDataCubit.stream).thenAnswer((_) => Stream.fromIterable([userState]));

    when(mockExplorePageCubit.state).thenReturn(exploreState);
    when(mockExplorePageCubit.stream).thenAnswer((_) => Stream.fromIterable([exploreState]));

    await tester.pumpWidget(
      buildTestWidget(userState: userState, exploreState: exploreState, carEntity: carEntity),
    );

    await tester.pumpAndSettle();

    expect(find.textContaining('Fiat 500'), findsOneWidget);
    expect(find.textContaining('10000'), findsOneWidget);
    expect(find.byType(InkWell), findsOneWidget);
  });
}
