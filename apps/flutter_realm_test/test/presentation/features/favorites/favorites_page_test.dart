import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:test_flutter_project/core/di/injection_container.dart';
import 'package:test_flutter_project/domain/entities/car_entity.dart';
import 'package:test_flutter_project/domain/entities/user_entity.dart';
import 'package:test_flutter_project/presentation/features/explore/explore_page_cubit.dart';
import 'package:test_flutter_project/presentation/features/explore/explore_page_state.dart';
import 'package:test_flutter_project/presentation/features/favorites/favorites_page.dart';
import 'package:test_flutter_project/presentation/features/favorites/favorites_page_identifiers.dart';
import 'package:test_flutter_project/presentation/features/l10n/app_localisations_cubit.dart';
import 'package:test_flutter_project/presentation/features/user/user_data_cubit.dart';
import 'package:test_flutter_project/presentation/features/user/user_data_state.dart';

import '../../../utils/app_router_test.mocks.dart';

void main() {
  final MockExplorePageCubit explorePageCubit = MockExplorePageCubit();
  final MockUserDataCubit userDataCubit = MockUserDataCubit();
  final appLocalisationsCubit = AppLocalisationsCubit();

  setUpAll(() {
    serviceLocator.registerSingleton<ExplorePageCubit>(explorePageCubit);
    serviceLocator.registerSingleton<UserDataCubit>(userDataCubit);

    serviceLocator.registerLazySingleton<AppLocalisationsCubit>(() => appLocalisationsCubit);
    final localisations = {'pages.favorites.title': 'Favorites'};
    appLocalisationsCubit.load(localisations);
  });

  tearDownAll(() async {
    await serviceLocator.reset();
  });

  Widget makeTestableWidget(Widget child) {
    return MaterialApp(
      home: MultiBlocProvider(
        providers: [
          BlocProvider<ExplorePageCubit>.value(value: explorePageCubit),
          BlocProvider<AppLocalisationsCubit>.value(value: appLocalisationsCubit),
          BlocProvider<UserDataCubit>.value(value: userDataCubit),
        ],
        child: child,
      ),
    );
  }

  testWidgets('displays the correct title', (tester) async {
    when(userDataCubit.state).thenReturn(UserDataState(user: UserEntity.empty()));
    when(userDataCubit.stream).thenAnswer((_) => const Stream.empty());

    when(explorePageCubit.state).thenReturn(const ExplorePageState(cars: []));
    when(explorePageCubit.stream).thenAnswer((_) => const Stream.empty());

    await tester.pumpWidget(makeTestableWidget(const FavoritesPage()));

    expect(
      find.text(
        appLocalisationsCubit.getLocalisationByKey(FavoritesPageLocaleKeys.favoritesPageTitle),
      ),
      findsOneWidget,
    );
  });

  testWidgets('shows only favorite cars', (tester) async {
    final car1 = CarEntity.empty().copyWith(carId: '1', model: 'Car 1');
    final car2 = CarEntity.empty().copyWith(carId: '2', model: 'Car 2');
    when(
      userDataCubit.state,
    ).thenReturn(UserDataState(user: UserEntity.empty().copyWith(favoriteIds: ['1'])));
    when(explorePageCubit.state).thenReturn(ExplorePageState(cars: [car1, car2]));

    when(userDataCubit.stream).thenAnswer((_) => const Stream.empty());
    when(explorePageCubit.stream).thenAnswer((_) => const Stream.empty());

    await tester.pumpWidget(makeTestableWidget(const FavoritesPage()));

    expect(find.textContaining('Car 1'), findsOneWidget);
    expect(find.textContaining('Car 2'), findsNothing);
  });

  testWidgets('shows empty state when no favorites', (tester) async {
    when(userDataCubit.state).thenReturn(UserDataState(user: UserEntity.empty()));
    when(explorePageCubit.state).thenReturn(const ExplorePageState(cars: []));

    await tester.pumpWidget(makeTestableWidget(const FavoritesPage()));

    // Replace with your actual empty state text
    expect(
      find.text(
        appLocalisationsCubit.getLocalisationByKey(
          FavoritesPageLocaleKeys.favoritesEmptyPlaceholder,
        ),
      ),
      findsOneWidget,
    );
  });

  testWidgets('delete button calls removeCarIdFromFavorites', (tester) async {
    final car = CarEntity.empty().copyWith(carId: '1', model: 'Car 1');
    when(
      userDataCubit.state,
    ).thenReturn(UserDataState(user: UserEntity.empty().copyWith(favoriteIds: ['1'])));
    when(explorePageCubit.state).thenReturn(ExplorePageState(cars: [car]));

    when(userDataCubit.stream).thenAnswer((_) => const Stream.empty());
    when(explorePageCubit.stream).thenAnswer((_) => const Stream.empty());

    await tester.pumpWidget(makeTestableWidget(const FavoritesPage()));

    // Find the delete button (adjust the finder as per your widget)
    final deleteButton = find.byIcon(Icons.favorite);
    expect(deleteButton, findsOneWidget);

    await tester.tap(deleteButton);
    await tester.pump();

    verify(userDataCubit.removeCarIdFromFavorites('1')).called(1);
  });
}
