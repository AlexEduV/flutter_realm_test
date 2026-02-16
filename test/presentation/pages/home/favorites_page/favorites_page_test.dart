import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:test_futter_project/domain/entities/car_entity.dart';
import 'package:test_futter_project/presentation/bloc/home/explore_page/explore_page_cubit.dart';
import 'package:test_futter_project/presentation/bloc/home/explore_page/explore_page_state.dart';
import 'package:test_futter_project/presentation/bloc/user/user_data_cubit.dart';
import 'package:test_futter_project/presentation/bloc/user/user_data_state.dart';
import 'package:test_futter_project/presentation/pages/home/favorites_page/favorites_page.dart';
import 'package:test_futter_project/utils/l10n.dart';

import '../../../../utils/app_router_test.mocks.dart';

void main() {
  late MockExplorePageCubit explorePageCubit;
  late MockUserDataCubit userDataCubit;

  setUp(() {
    explorePageCubit = MockExplorePageCubit();
    userDataCubit = MockUserDataCubit();
  });

  Widget makeTestableWidget(Widget child) {
    return MaterialApp(
      home: MultiBlocProvider(
        providers: [
          BlocProvider<ExplorePageCubit>.value(value: explorePageCubit),
          BlocProvider<UserDataCubit>.value(value: userDataCubit),
        ],
        child: child,
      ),
    );
  }

  testWidgets('displays the correct title', (tester) async {
    when(userDataCubit.state).thenReturn(const UserDataState(favoriteIds: []));
    when(explorePageCubit.state).thenReturn(const ExplorePageState(cars: []));

    await tester.pumpWidget(makeTestableWidget(const FavoritesPage()));

    expect(find.text(AppLocalisations.favoritesPageTitle), findsOneWidget);
  });

  testWidgets('shows only favorite cars', (tester) async {
    final car1 = CarEntity.empty().copyWith(carId: '1', model: 'Car 1');
    final car2 = CarEntity.empty().copyWith(carId: '2', model: 'Car 2');
    when(userDataCubit.state).thenReturn(const UserDataState(favoriteIds: ['1']));
    when(explorePageCubit.state).thenReturn(ExplorePageState(cars: [car1, car2]));

    await tester.pumpWidget(makeTestableWidget(const FavoritesPage()));

    expect(find.text('Car 1'), findsOneWidget);
    expect(find.text('Car 2'), findsNothing);
  });

  testWidgets('shows empty state when no favorites', (tester) async {
    when(userDataCubit.state).thenReturn(const UserDataState(favoriteIds: []));
    when(explorePageCubit.state).thenReturn(const ExplorePageState(cars: []));

    await tester.pumpWidget(makeTestableWidget(const FavoritesPage()));

    // Replace with your actual empty state text
    expect(find.text(AppLocalisations.emptySearchPlaceholderText), findsOneWidget);
  });

  testWidgets('delete button calls removeCarIdFromFavorites', (tester) async {
    final car = CarEntity.empty().copyWith(carId: '1', model: 'Car 1');
    when(userDataCubit.state).thenReturn(const UserDataState(favoriteIds: ['1']));
    when(explorePageCubit.state).thenReturn(ExplorePageState(cars: [car]));

    await tester.pumpWidget(makeTestableWidget(const FavoritesPage()));

    // Find the delete button (adjust the finder as per your widget)
    final deleteButton = find.byIcon(Icons.delete);
    expect(deleteButton, findsOneWidget);

    await tester.tap(deleteButton);
    await tester.pump();

    verify(() => userDataCubit.removeCarIdFromFavorites('1')).called(1);
  });
}
