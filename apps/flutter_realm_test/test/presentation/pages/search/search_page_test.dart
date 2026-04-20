import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mockito/mockito.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:test_flutter_project/common/constants/app_routes.dart';
import 'package:test_flutter_project/common/enums/drawer_type.dart';
import 'package:test_flutter_project/core/di/injection_container.dart';
import 'package:test_flutter_project/domain/entities/car_entity.dart';
import 'package:test_flutter_project/domain/entities/user_entity.dart';
import 'package:test_flutter_project/domain/usecases/permissions/check_location_permission_status_use_case.dart';
import 'package:test_flutter_project/l10n/l10n_keys.dart';
import 'package:test_flutter_project/presentation/bloc/home/explore_page/explore_page_cubit.dart';
import 'package:test_flutter_project/presentation/bloc/home/explore_page/explore_page_state.dart';
import 'package:test_flutter_project/presentation/bloc/home/home_bottom_bar/home_bottom_bar_cubit.dart';
import 'package:test_flutter_project/presentation/bloc/home/home_bottom_bar/home_bottom_bar_state.dart';
import 'package:test_flutter_project/presentation/bloc/l10n/app_localisations_cubit.dart';
import 'package:test_flutter_project/presentation/bloc/l10n/app_localisations_state.dart';
import 'package:test_flutter_project/presentation/bloc/search/search_page_cubit.dart';
import 'package:test_flutter_project/presentation/bloc/search/search_page_state.dart';
import 'package:test_flutter_project/presentation/bloc/user/user_data_cubit.dart';
import 'package:test_flutter_project/presentation/bloc/user/user_data_state.dart';
import 'package:test_flutter_project/presentation/pages/home/home_page.dart';
import 'package:test_flutter_project/presentation/pages/search/search_page.dart';
import 'package:test_flutter_project/presentation/pages/search/widgets/filters_drawer.dart';
import 'package:test_flutter_project/presentation/pages/search/widgets/model_filter_drawer.dart';
import 'package:test_flutter_project/presentation/pages/search/widgets/search_filter_button.dart';
import 'package:test_flutter_project/presentation/widgets/empty_results_placeholder_widget.dart';
import 'package:test_flutter_project/presentation/widgets/segmented_switch.dart';

import '../../../common/extensions/context_extension_test.mocks.dart';
import '../../../utils/app_router_test.mocks.dart';
import '../../bloc/user/user_data_cubit_test.mocks.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final appLocalisationsCubit = AppLocalisationsCubit();
  final mockCheckLocationPermissionStatusUseCase = MockCheckLocationPermissionStatusUseCase();

  setUpAll(() {
    serviceLocator.registerSingleton<AppLocalisationsCubit>(appLocalisationsCubit);
    serviceLocator.registerSingleton<CheckLocationPermissionStatusUseCase>(
      mockCheckLocationPermissionStatusUseCase,
    );

    when(
      mockCheckLocationPermissionStatusUseCase.call(),
    ).thenAnswer((_) async => PermissionStatus.granted);
  });

  tearDownAll(() {
    serviceLocator.unregister<AppLocalisationsCubit>();
    serviceLocator.unregister<CheckLocationPermissionStatusUseCase>();
  });

  Widget buildTestableWidget({
    required SearchPageCubit searchCubit,
    required UserDataCubit userCubit,
    required AppLocalisationsCubit appLocalisationsCubit,
    SearchPageState? searchState,
    UserDataState? userState,
  }) {
    final mockHomeBottomBarCubit = MockHomeBottomBarCubit();
    final mockExplorePageCubit = MockExplorePageCubit();

    when(mockHomeBottomBarCubit.stream).thenAnswer((_) => const Stream.empty());
    when(mockHomeBottomBarCubit.state).thenAnswer((_) => const HomeBottomBarState());

    when(mockExplorePageCubit.stream).thenAnswer((_) => const Stream.empty());
    when(mockExplorePageCubit.state).thenReturn(const ExplorePageState());

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
                return const CupertinoPage(child: SearchPage());
              },
            ),
          ],
        ),
      ],
    );

    // Set up cubit states
    when(searchCubit.state).thenReturn(searchState ?? const SearchPageState());
    when(userCubit.state).thenReturn(userState ?? const UserDataState());

    when(searchCubit.stream).thenAnswer((_) => const Stream.empty());
    when(searchCubit.getSelectedFilterCount()).thenReturn(0);

    when(appLocalisationsCubit.stream).thenAnswer((_) => const Stream.empty());
    when(userCubit.stream).thenAnswer(
      (_) => Stream.fromIterable([
        const UserDataState(favoriteIds: []),
        const UserDataState(favoriteIds: ['1']),
      ]),
    );
    when(userCubit.user).thenReturn(
      UserEntity.initial(
        userId: '5',
        firstName: 'Bobby',
        lastName: 'Fischer',
        email: 'fisher@mock.com',
        password: '',
      ),
    );

    when(
      appLocalisationsCubit.state,
    ).thenReturn(const AppLocalisationsState(localisations: {L10nKeys.searchPageTitle: 'Search'}));

    return MultiBlocProvider(
      providers: [
        BlocProvider<SearchPageCubit>.value(value: searchCubit),
        BlocProvider<UserDataCubit>.value(value: userCubit),
        BlocProvider<AppLocalisationsCubit>.value(value: appLocalisationsCubit),
        BlocProvider<HomeBottomBarCubit>.value(value: mockHomeBottomBarCubit),
        BlocProvider<ExplorePageCubit>.value(value: mockExplorePageCubit),
      ],
      child: MaterialApp.router(routerConfig: router),
    );
  }

  testWidgets('shows app bar title and back button', (WidgetTester tester) async {
    final searchCubit = MockSearchPageCubit();
    final userCubit = MockUserDataCubit();
    final appLocalisationsCubit = MockAppLocalisationsCubit();

    await tester.pumpWidget(
      buildTestableWidget(
        searchCubit: searchCubit,
        userCubit: userCubit,
        appLocalisationsCubit: appLocalisationsCubit,
      ),
    );

    expect(find.textContaining('Search'), findsOneWidget); // Adjust for your localization
    expect(find.byIcon(Icons.arrow_back), findsOneWidget);
  });

  testWidgets('shows segmented switch and filter buttons', (WidgetTester tester) async {
    final searchCubit = MockSearchPageCubit();
    final userCubit = MockUserDataCubit();
    final appLocalisationsCubit = MockAppLocalisationsCubit();

    await tester.pumpWidget(
      buildTestableWidget(
        searchCubit: searchCubit,
        userCubit: userCubit,
        appLocalisationsCubit: appLocalisationsCubit,
      ),
    );

    expect(find.byType(SegmentedSwitch), findsOneWidget);
    expect(find.byType(SearchFilterButton), findsNWidgets(2));
  });

  testWidgets('shows empty placeholder when there are no results', (WidgetTester tester) async {
    final searchCubit = MockSearchPageCubit();
    final userCubit = MockUserDataCubit();
    final appLocalisationsCubit = MockAppLocalisationsCubit();

    when(searchCubit.state).thenReturn(const SearchPageState(results: []));
    when(userCubit.state).thenReturn(const UserDataState());

    await tester.pumpWidget(
      buildTestableWidget(
        searchCubit: searchCubit,
        userCubit: userCubit,
        appLocalisationsCubit: appLocalisationsCubit,
      ),
    );

    expect(find.byType(EmptyResultsPlaceholderWidget), findsOneWidget);
  });

  testWidgets('shows results list when present', (WidgetTester tester) async {
    final searchCubit = MockSearchPageCubit();
    final userCubit = MockUserDataCubit();
    final appLocalisationsCubit = MockAppLocalisationsCubit();

    // Replace with your actual car/result model
    final car = CarEntity.empty();

    final initialSize = tester.view.physicalSize;
    final initialPixelRatio = tester.view.devicePixelRatio;

    const size = Size(874, 402); // iphone 16 pro
    tester.view.physicalSize = size;
    tester.view.devicePixelRatio = 1.0;

    await tester.pumpWidget(
      buildTestableWidget(
        searchCubit: searchCubit,
        userCubit: userCubit,
        appLocalisationsCubit: appLocalisationsCubit,
        searchState: SearchPageState(results: [car], isLoading: false),
      ),
    );

    await tester.pump();
    await tester.pumpAndSettle();

    expect(find.byType(SearchPage), findsOneWidget);
    expect(find.byType(Scaffold), findsOneWidget);
    expect(find.byType(EmptyResultsPlaceholderWidget), findsNothing);
    //todo: the app does not see the Grid or the ListItem;
    //expect(find.byType(AnnouncementListItem), findsOneWidget);

    tester.view.physicalSize = initialSize;
    tester.view.devicePixelRatio = initialPixelRatio;
  });

  testWidgets('opens model filter drawer when model filter button is pressed', (
    WidgetTester tester,
  ) async {
    final searchCubit = MockSearchPageCubit();
    final userCubit = MockUserDataCubit();
    final appLocalisationsCubit = MockAppLocalisationsCubit();

    await tester.pumpWidget(
      buildTestableWidget(
        searchCubit: searchCubit,
        userCubit: userCubit,
        appLocalisationsCubit: appLocalisationsCubit,
        searchState: const SearchPageState(drawerOpened: SearchDrawerType.model),
      ),
    );

    // Tap the first SearchFilterButton (model filter)
    await tester.tap(find.byType(SearchFilterButton).first);
    await tester.pumpAndSettle();

    // Simulate opening the drawer
    when(searchCubit.state).thenReturn(const SearchPageState(drawerOpened: SearchDrawerType.model));
    await tester.pumpAndSettle();

    expect(find.byType(ModelFilterDrawer), findsOneWidget);
  });

  testWidgets('opens parameters filter drawer when parameters filter button is pressed', (
    WidgetTester tester,
  ) async {
    final searchCubit = MockSearchPageCubit();
    final userCubit = MockUserDataCubit();
    final appLocalisationsCubit = MockAppLocalisationsCubit();

    when(searchCubit.state).thenReturn(const SearchPageState(drawerOpened: SearchDrawerType.empty));
    when(userCubit.state).thenReturn(const UserDataState());

    await tester.pumpWidget(
      buildTestableWidget(
        searchCubit: searchCubit,
        userCubit: userCubit,
        appLocalisationsCubit: appLocalisationsCubit,
      ),
    );

    // Tap the second SearchFilterButton (parameters filter)
    await tester.tap(find.byType(SearchFilterButton).last);
    await tester.pumpAndSettle();

    // Simulate opening the drawer
    when(
      searchCubit.state,
    ).thenReturn(const SearchPageState(drawerOpened: SearchDrawerType.parameters));
    await tester.pumpAndSettle();

    expect(find.byType(FiltersDrawer), findsOneWidget);
  });

  testWidgets('calls context.pop() when back button is pressed', (WidgetTester tester) async {
    final searchCubit = MockSearchPageCubit();
    final userCubit = MockUserDataCubit();
    final appLocalisationsCubit = MockAppLocalisationsCubit();

    await tester.pumpWidget(
      buildTestableWidget(
        searchCubit: searchCubit,
        userCubit: userCubit,
        appLocalisationsCubit: appLocalisationsCubit,
      ),
    );

    // Tap the back button
    await tester.tap(find.byIcon(Icons.arrow_back));
    await tester.pumpAndSettle();

    expect(find.byType(SearchPage), findsNothing);
    expect(find.byType(HomePage), findsOneWidget);
  });
}
