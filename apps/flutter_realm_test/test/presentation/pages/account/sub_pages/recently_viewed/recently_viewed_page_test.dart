import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:test_flutter_project/core/di/injection_container.dart';
import 'package:test_flutter_project/domain/entities/car_entity.dart';
import 'package:test_flutter_project/l10n/l10n_keys.dart';
import 'package:test_flutter_project/presentation/bloc/home/explore_page/explore_page_cubit.dart';
import 'package:test_flutter_project/presentation/bloc/home/explore_page/explore_page_state.dart';
import 'package:test_flutter_project/presentation/bloc/l10n/app_localisations_cubit.dart';
import 'package:test_flutter_project/presentation/bloc/l10n/app_localisations_state.dart';
import 'package:test_flutter_project/presentation/bloc/user/user_data_cubit.dart';
import 'package:test_flutter_project/presentation/bloc/user/user_data_state.dart';
import 'package:test_flutter_project/presentation/pages/account/sub_pages/recently_viewed/recently_viewed_page.dart';
import 'package:test_flutter_project/presentation/pages/home/widgets/car_list_item.dart';

import '../../../../../common/extensions/context_extension_test.mocks.dart';
import '../../../../../utils/app_router_test.mocks.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockUserDataCubit mockUserDataCubit;
  late MockExplorePageCubit mockExplorePageCubit;
  final mockAppLocalisationsCubit = MockAppLocalisationsCubit();

  setUp(() {
    mockUserDataCubit = MockUserDataCubit();
    mockExplorePageCubit = MockExplorePageCubit();

    serviceLocator.registerSingleton<UserDataCubit>(mockUserDataCubit);
  });

  tearDown(() {
    serviceLocator.unregister<UserDataCubit>();
  });

  Widget buildTestable({required UserDataState userState, required ExplorePageState exploreState}) {
    when(mockUserDataCubit.state).thenReturn(userState);
    when(mockExplorePageCubit.state).thenReturn(exploreState);

    when(mockAppLocalisationsCubit.state).thenReturn(
      const AppLocalisationsState(
        localisations: {
          L10nKeys.accountItemViewedItems: 'Viewed items',
          L10nKeys.viewedItemsNoResultsPlaceholder: 'No results',
        },
      ),
    );

    when(mockAppLocalisationsCubit.stream).thenAnswer((_) => const Stream.empty());
    when(mockUserDataCubit.stream).thenAnswer((_) => const Stream.empty());
    when(mockExplorePageCubit.stream).thenAnswer((_) => const Stream.empty());

    return MaterialApp(
      home: MultiBlocProvider(
        providers: [
          BlocProvider<UserDataCubit>.value(value: mockUserDataCubit),
          BlocProvider<ExplorePageCubit>.value(value: mockExplorePageCubit),
          BlocProvider<AppLocalisationsCubit>.value(value: mockAppLocalisationsCubit),
        ],
        child: const RecentlyViewedPage(),
      ),
    );
  }

  testWidgets('shows empty placeholder when viewedIds is empty', (tester) async {
    final userState = const UserDataState(viewedIds: []);
    final exploreState = const ExplorePageState(cars: []);

    await tester.pumpWidget(buildTestable(userState: userState, exploreState: exploreState));

    await tester.pumpAndSettle();

    expect(find.textContaining('No results', findRichText: true), findsOneWidget);
  });

  testWidgets('shows car list items for each viewedId', (tester) async {
    final car1 = CarEntity.empty().copyWith(carId: 'car1', model: 'Model 1');
    final car2 = CarEntity.empty().copyWith(carId: 'car2', model: 'Model 2');
    final userState = const UserDataState(viewedIds: ['car1', 'car2']);
    final exploreState = ExplorePageState(cars: [car1, car2]);

    await tester.pumpWidget(buildTestable(userState: userState, exploreState: exploreState));

    // Should show a CarListItem for each viewed car
    expect(find.byType(CarListItem), findsNWidgets(2));
    // Optionally, check that the correct models are displayed
    expect(find.textContaining('Model 1'), findsOneWidget);
    expect(find.textContaining('Model 2'), findsOneWidget);
  });
}
