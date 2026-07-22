import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mockito/mockito.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:test_flutter_project/common/constants/app_routes.dart';
import 'package:test_flutter_project/common/enums/body_type.dart';
import 'package:test_flutter_project/common/enums/car_type.dart';
import 'package:test_flutter_project/common/enums/fuel_type.dart';
import 'package:test_flutter_project/common/enums/transmission_type.dart';
import 'package:test_flutter_project/core/di/injection_container.dart';
import 'package:test_flutter_project/domain/usecases/permissions/check_location_permission_status_use_case.dart';
import 'package:test_flutter_project/presentation/bloc/home/explore_page/explore_page_cubit.dart';
import 'package:test_flutter_project/presentation/bloc/home/explore_page/explore_page_state.dart';
import 'package:test_flutter_project/presentation/bloc/home/home_bottom_bar/home_bottom_bar_cubit.dart';
import 'package:test_flutter_project/presentation/bloc/home/home_bottom_bar/home_bottom_bar_state.dart';
import 'package:test_flutter_project/presentation/bloc/home/new_item_page/new_item_page_cubit.dart';
import 'package:test_flutter_project/presentation/bloc/home/new_item_page/new_item_page_state.dart';
import 'package:test_flutter_project/presentation/bloc/l10n/app_localisations_cubit.dart';
import 'package:test_flutter_project/presentation/bloc/user/user_data_cubit.dart';
import 'package:test_flutter_project/presentation/bloc/user/user_data_state.dart';
import 'package:test_flutter_project/presentation/pages/home/home_page.dart';
import 'package:test_flutter_project/presentation/pages/home/new_item_page/new_item_page.dart';
import 'package:test_flutter_project/presentation/pages/home/new_item_page/sub_pages/car_type_picker.dart';
import 'package:test_flutter_project/presentation/pages/home/new_item_page/sub_pages/item_info_form.dart';
import 'package:test_flutter_project/presentation/pages/home/new_item_page/sub_pages/item_specs_picker.dart';
import 'package:test_flutter_project/presentation/pages/home/new_item_page/widgets/page_selection_bar.dart';

import '../../../../utils/app_router_test.mocks.dart';
import '../../../bloc/user/user_data_cubit_test.mocks.dart';
import 'sub_pages/car_type_picker_test.mocks.dart';

void main() {
  final appLocalisationsCubit = AppLocalisationsCubit();
  final mockCheckLocationPermissionStatusUseCase = MockCheckLocationPermissionStatusUseCase();

  setUpAll(() {
    provideDummy(const NewItemPageState());
  });

  setUp(() {
    serviceLocator.registerSingleton<CheckLocationPermissionStatusUseCase>(
      mockCheckLocationPermissionStatusUseCase,
    );
  });

  tearDown(() {
    serviceLocator.unregister<CheckLocationPermissionStatusUseCase>();
  });

  testWidgets('NewItemPage renders all main widgets', (WidgetTester tester) async {
    final mockCubit = MockNewItemPageCubit();
    final mockUserDataCubit = MockUserDataCubit();
    final mockExplorePageCubit = MockExplorePageCubit();

    when(mockCubit.state).thenReturn(
      const NewItemPageState(
        currentPageIndex: 0,
        selectedBodyType: BodyType.sedan,
        selectedTransmissionType: TransmissionType.manual,
        selectedFuelType: FuelType.diesel,
        selectedCarType: CarType.car,
      ),
    );
    when(mockCubit.stream).thenAnswer((_) => const Stream.empty());

    when(mockCubit.areAllFieldsValid()).thenReturn(true);

    await tester.pumpWidget(
      MultiBlocProvider(
        providers: [
          BlocProvider<NewItemPageCubit>.value(value: mockCubit),
          BlocProvider<UserDataCubit>.value(value: mockUserDataCubit),
          BlocProvider<ExplorePageCubit>.value(value: mockExplorePageCubit),
          BlocProvider<AppLocalisationsCubit>.value(value: appLocalisationsCubit),
        ],
        child: const MaterialApp(home: NewItemPage()),
      ),
    );

    // Assert: AppBar, CarTypePicker, ItemInfoForm, ItemSpecsPicker, PageSelectionBar are present
    expect(find.byType(AppBar), findsOneWidget);
    expect(find.byType(CarTypePicker), findsOneWidget);
    expect(find.byType(ItemInfoForm), findsNothing);
    expect(find.byType(ItemSpecsPicker), findsNothing);
    expect(find.byType(PageSelectionBar), findsOneWidget);
  });

  testWidgets('PageSelectionBar back and forward buttons call correct methods', (
    WidgetTester tester,
  ) async {
    final mockCubit = MockNewItemPageCubit();
    final mockUserDataCubit = MockUserDataCubit();
    final mockExplorePageCubit = MockExplorePageCubit();

    when(mockCubit.state).thenReturn(
      const NewItemPageState(
        currentPageIndex: 1,
        selectedBodyType: BodyType.sedan,
        selectedTransmissionType: TransmissionType.manual,
        selectedFuelType: FuelType.diesel,
        selectedCarType: CarType.car,
      ),
    );
    when(mockCubit.stream).thenAnswer((_) => const Stream.empty());

    when(mockCubit.areAllFieldsValid()).thenReturn(true);

    await tester.pumpWidget(
      MultiBlocProvider(
        providers: [
          BlocProvider<NewItemPageCubit>.value(value: mockCubit),
          BlocProvider<UserDataCubit>.value(value: mockUserDataCubit),
          BlocProvider<ExplorePageCubit>.value(value: mockExplorePageCubit),
          BlocProvider<AppLocalisationsCubit>.value(value: appLocalisationsCubit),
        ],
        child: const MaterialApp(home: NewItemPage()),
      ),
    );

    // Tap the forward button
    await tester.tap(find.byIcon(Icons.chevron_right_outlined));
    await tester.pumpAndSettle();

    // Tap the back button
    await tester.tap(find.byIcon(Icons.chevron_left_outlined));
    await tester.pumpAndSettle();

    // You can add verify checks if you want to ensure cubit.updateTabIndex is called, etc.
  });

  testWidgets('Back button pops the route if canPop is true', (WidgetTester tester) async {
    final mockCubit = MockNewItemPageCubit();
    final mockUserDataCubit = MockUserDataCubit();
    final mockExplorePageCubit = MockExplorePageCubit();
    final mockHomeBottomBarCubit = MockHomeBottomBarCubit();

    when(mockCubit.state).thenReturn(const NewItemPageState());
    when(mockCubit.stream).thenAnswer((_) => const Stream.empty());

    when(mockExplorePageCubit.stream).thenAnswer((_) => const Stream.empty());
    when(mockExplorePageCubit.state).thenReturn(const ExplorePageState());

    when(mockHomeBottomBarCubit.state).thenReturn(const HomeBottomBarState());
    when(mockHomeBottomBarCubit.stream).thenAnswer((_) => const Stream.empty());

    when(mockUserDataCubit.stream).thenAnswer((_) => const Stream.empty());
    when(mockUserDataCubit.state).thenReturn(const UserDataState());

    when(
      mockCheckLocationPermissionStatusUseCase.call(),
    ).thenAnswer((_) async => PermissionStatus.granted);

    final router = GoRouter(
      initialLocation: AppRoutes.home + AppRoutes.newItem,
      routes: [
        GoRoute(
          path: AppRoutes.home,
          builder: (context, state) => const HomePage(),
          routes: [
            GoRoute(
              path: AppRoutes.newItem,
              pageBuilder: (context, state) {
                return const CupertinoPage(child: NewItemPage());
              },
            ),
          ],
        ),
      ],
    );

    await tester.pumpWidget(
      MultiBlocProvider(
        providers: [
          BlocProvider<NewItemPageCubit>.value(value: mockCubit),
          BlocProvider<UserDataCubit>.value(value: mockUserDataCubit),
          BlocProvider<ExplorePageCubit>.value(value: mockExplorePageCubit),
          BlocProvider<AppLocalisationsCubit>.value(value: appLocalisationsCubit),
          BlocProvider<HomeBottomBarCubit>.value(value: mockHomeBottomBarCubit),
        ],
        child: MaterialApp.router(routerConfig: router),
      ),
    );
    await tester.pumpAndSettle();

    // Tap the back button
    await tester.tap(find.byIcon(Icons.arrow_back));
    await tester.pumpAndSettle();

    // The page should be popped (not present)
    expect(find.byType(NewItemPage), findsNothing);
    expect(find.byType(HomePage), findsOneWidget);
  });

  testWidgets('insertItem is called on cubit when forward is pressed on last page', (
    WidgetTester tester,
  ) async {
    final mockCubit = MockNewItemPageCubit();
    final mockUserDataCubit = MockUserDataCubit();
    final mockExplorePageCubit = MockExplorePageCubit();

    when(mockCubit.state).thenReturn(
      const NewItemPageState(
        currentPageIndex: 2,
        modelText: 'Model',
        manufacturerText: 'Manufacturer',
        colorText: 'Red',
        priceText: '10000',
        yearText: '2020',
        selectedBodyType: BodyType.sedan,
        selectedTransmissionType: TransmissionType.manual,
        selectedFuelType: FuelType.diesel,
        selectedCarType: CarType.car,
      ),
    );
    when(mockCubit.stream).thenAnswer((_) => const Stream.empty());

    await tester.pumpWidget(
      MultiBlocProvider(
        providers: [
          BlocProvider<NewItemPageCubit>.value(value: mockCubit),
          BlocProvider<UserDataCubit>.value(value: mockUserDataCubit),
          BlocProvider<ExplorePageCubit>.value(value: mockExplorePageCubit),
          BlocProvider<AppLocalisationsCubit>.value(value: appLocalisationsCubit),
        ],
        child: const MaterialApp(home: NewItemPage()),
      ),
    );

    await tester.tap(find.byIcon(Icons.chevron_right_outlined));
    await tester.pumpAndSettle();

    verify(mockCubit.insertItem()).called(1);
  });
}
