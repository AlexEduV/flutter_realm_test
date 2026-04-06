import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:test_futter_project/common/constants/app_routes.dart';
import 'package:test_futter_project/common/enums/details_page_source.dart';
import 'package:test_futter_project/core/di/injection_container.dart';
import 'package:test_futter_project/domain/entities/user_entity.dart';
import 'package:test_futter_project/domain/usecases/permissions/check_location_permission_status_use_case.dart';
import 'package:test_futter_project/presentation/bloc/details/details_page_cubit.dart';
import 'package:test_futter_project/presentation/bloc/details/details_page_state.dart';
import 'package:test_futter_project/presentation/bloc/home/explore_page/explore_page_cubit.dart';
import 'package:test_futter_project/presentation/bloc/home/explore_page/explore_page_state.dart';
import 'package:test_futter_project/presentation/bloc/home/home_bottom_bar/home_bottom_bar_cubit.dart';
import 'package:test_futter_project/presentation/bloc/home/home_bottom_bar/home_bottom_bar_state.dart';
import 'package:test_futter_project/presentation/bloc/l10n/app_localisations_cubit.dart';
import 'package:test_futter_project/presentation/bloc/search/search_page_cubit.dart';
import 'package:test_futter_project/presentation/bloc/search/search_page_state.dart';
import 'package:test_futter_project/presentation/bloc/user/user_data_cubit.dart';
import 'package:test_futter_project/presentation/bloc/user/user_data_state.dart';
import 'package:test_futter_project/presentation/pages/details/details_page.dart';
import 'package:test_futter_project/presentation/pages/home/home_page.dart';
import 'package:test_futter_project/presentation/pages/search/search_page.dart';
import 'package:test_futter_project/utils/app_router.dart';

import '../presentation/bloc/user/user_data_cubit_test.mocks.dart';
import 'app_router_test.mocks.dart';

@GenerateMocks([
  HomeBottomBarCubit,
  ExplorePageCubit,
  UserDataCubit,
  SearchPageCubit,
  DetailsPageCubit,
])
void main() {
  final MockHomeBottomBarCubit homeBottomBarCubit = MockHomeBottomBarCubit();
  final MockExplorePageCubit explorePageCubit = MockExplorePageCubit();
  final MockUserDataCubit mockUserDataCubit = MockUserDataCubit();
  final MockSearchPageCubit mockSearchPageCubit = MockSearchPageCubit();
  final MockDetailsPageCubit mockDetailsPageCubit = MockDetailsPageCubit();
  final AppLocalisationsCubit appLocalisationsCubit = AppLocalisationsCubit();
  final MockCheckLocationPermissionStatusUseCase mockCheckLocationPermissionStatusUseCase =
      MockCheckLocationPermissionStatusUseCase();

  late Widget widget;

  setUpAll(() {
    serviceLocator.registerLazySingleton<CheckLocationPermissionStatusUseCase>(
      () => mockCheckLocationPermissionStatusUseCase,
    );

    when(
      mockCheckLocationPermissionStatusUseCase.call(),
    ).thenAnswer((_) async => PermissionStatus.granted);

    when(homeBottomBarCubit.stream).thenAnswer((_) => const Stream.empty());
    when(homeBottomBarCubit.state).thenReturn(const HomeBottomBarState());

    when(explorePageCubit.stream).thenAnswer((_) => const Stream.empty());
    when(explorePageCubit.state).thenReturn(const ExplorePageState(cars: [], isLoading: false));

    when(mockUserDataCubit.stream).thenAnswer((_) => const Stream.empty());
    when(
      mockUserDataCubit.state,
    ).thenReturn(const UserDataState(isLocationPermissionGranted: true));

    when(mockSearchPageCubit.stream).thenAnswer((_) => const Stream.empty());
    when(mockSearchPageCubit.state).thenReturn(const SearchPageState());

    when(mockDetailsPageCubit.stream).thenAnswer((_) => const Stream.empty());
    when(mockDetailsPageCubit.state).thenReturn(const DetailsPageState());

    when(mockUserDataCubit.user).thenReturn(
      UserEntity.initial(
        userId: '1',
        firstName: 'Alexander',
        lastName: 'the Third',
        email: 'alexander-iii@pella.mk',
        password: 'daGreat',
      ),
    );
  });

  setUp(() {
    widget = MultiBlocProvider(
      providers: [
        BlocProvider<HomeBottomBarCubit>(create: (context) => homeBottomBarCubit),
        BlocProvider<ExplorePageCubit>(create: (context) => explorePageCubit),
        BlocProvider<UserDataCubit>(create: (context) => mockUserDataCubit),
        BlocProvider<SearchPageCubit>(create: (context) => mockSearchPageCubit),
        BlocProvider<DetailsPageCubit>(create: (context) => mockDetailsPageCubit),
        BlocProvider<AppLocalisationsCubit>(create: (context) => appLocalisationsCubit),
      ],
      child: MaterialApp.router(routerConfig: AppRouter.router),
    );
  });

  tearDownAll(() {
    serviceLocator.unregister<CheckLocationPermissionStatusUseCase>();
  });

  testWidgets('Navigates to HomePage on root route', (WidgetTester tester) async {
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();

    expect(find.byType(HomePage), findsOneWidget);
    expect(find.byType(SearchPage), findsNothing);
  });

  testWidgets('Navigates to SearchPage on /search route', (WidgetTester tester) async {
    when(mockSearchPageCubit.getSelectedFilterCount()).thenReturn(0);

    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();

    // Navigate to /search
    AppRouter.router.go(AppRoutes.home + AppRoutes.search);
    await tester.pumpAndSettle();

    expect(find.byType(SearchPage), findsOneWidget);
    expect(find.byType(HomePage), findsNothing);
  });

  testWidgets('Navigates to DetailsPage from Explore', (tester) async {
    await tester.pumpWidget(widget);

    AppRouter.goToDetails(carId: 'car123', from: DetailsPageSource.explore);
    await tester.pumpAndSettle();
    expect(find.byType(DetailsPage), findsOneWidget);
    final detailsPage = tester.widget<DetailsPage>(find.byType(DetailsPage));
    expect(detailsPage.carId, 'car123');
  });

  testWidgets('Navigates to DetailsPage from Search', (tester) async {
    await tester.pumpWidget(widget);

    AppRouter.goToDetails(from: DetailsPageSource.search, carId: 'car456');
    await tester.pumpAndSettle();
    expect(find.byType(DetailsPage), findsOneWidget);
    final detailsPage = tester.widget<DetailsPage>(find.byType(DetailsPage));
    expect(detailsPage.carId, 'car456');
  });

  testWidgets('DetailsPage carId is empty string if not provided', (tester) async {
    await tester.pumpWidget(widget);

    AppRouter.router.go('${AppRoutes.home}${AppRoutes.details}');
    await tester.pumpAndSettle();
    final detailsPage = tester.widget<DetailsPage>(find.byType(DetailsPage));
    expect(detailsPage.carId, '');
  });

  test('AppRouter.router is a GoRouter', () {
    expect(AppRouter.router, isA<GoRouter>());
  });
}
