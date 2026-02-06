import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test_futter_project/common/app_routes.dart';
import 'package:test_futter_project/presentation/bloc/home/explore_page/explore_page_cubit.dart';
import 'package:test_futter_project/presentation/bloc/home/explore_page/explore_page_state.dart';
import 'package:test_futter_project/presentation/bloc/home/home_bottom_bar/home_bottom_bar_cubit.dart';
import 'package:test_futter_project/presentation/bloc/home/home_bottom_bar/home_bottom_bar_state.dart';
import 'package:test_futter_project/presentation/bloc/search/search_page_cubit.dart';
import 'package:test_futter_project/presentation/bloc/search/search_page_state.dart';
import 'package:test_futter_project/presentation/bloc/user/user_data_cubit.dart';
import 'package:test_futter_project/presentation/bloc/user/user_data_state.dart';
import 'package:test_futter_project/presentation/pages/home/home_page.dart';
import 'package:test_futter_project/presentation/pages/search/search_page.dart';
import 'package:test_futter_project/utils/app_router.dart';

import 'app_router_test.mocks.dart';

@GenerateMocks([HomeBottomBarCubit, ExplorePageCubit, UserDataCubit, SearchPageCubit])
void main() {
  final MockHomeBottomBarCubit homeBottomBarCubit = MockHomeBottomBarCubit();
  final MockExplorePageCubit explorePageCubit = MockExplorePageCubit();
  final MockUserDataCubit mockUserDataCubit = MockUserDataCubit();
  final MockSearchPageCubit mockSearchPageCubit = MockSearchPageCubit();

  setUpAll(() {
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
  });

  testWidgets('Navigates to HomePage on root route', (WidgetTester tester) async {
    await tester.pumpWidget(
      MultiBlocProvider(
        providers: [
          BlocProvider<HomeBottomBarCubit>(create: (context) => homeBottomBarCubit),
          BlocProvider<ExplorePageCubit>(create: (context) => explorePageCubit),
          BlocProvider<UserDataCubit>(create: (context) => mockUserDataCubit),
        ],
        child: MaterialApp.router(routerConfig: AppRouter.router),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byType(HomePage), findsOneWidget);
    expect(find.byType(SearchPage), findsNothing);
  });

  testWidgets('Navigates to SearchPage on /search route', (WidgetTester tester) async {
    when(mockSearchPageCubit.getSelectedFilterCount()).thenReturn(0);

    await tester.pumpWidget(
      MultiBlocProvider(
        providers: [
          BlocProvider<HomeBottomBarCubit>(create: (context) => homeBottomBarCubit),
          BlocProvider<ExplorePageCubit>(create: (context) => explorePageCubit),
          BlocProvider<UserDataCubit>(create: (context) => mockUserDataCubit),
          BlocProvider<SearchPageCubit>(create: (context) => mockSearchPageCubit),
        ],
        child: MaterialApp.router(routerConfig: AppRouter.router),
      ),
    );
    await tester.pumpAndSettle();

    // Navigate to /search
    AppRouter.router.go(AppRoutes.home + AppRoutes.search);
    await tester.pumpAndSettle();

    expect(find.byType(SearchPage), findsOneWidget);
    expect(find.byType(HomePage), findsNothing);
  });

  test('AppRouter.router is a GoRouter', () {
    expect(AppRouter.router, isA<GoRouter>());
  });
}
