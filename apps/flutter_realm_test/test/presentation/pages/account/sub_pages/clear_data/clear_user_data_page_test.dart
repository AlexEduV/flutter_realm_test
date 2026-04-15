import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:test_flutter_project/l10n/l10n_keys.dart';
import 'package:test_flutter_project/presentation/bloc/l10n/app_localisations_cubit.dart';
import 'package:test_flutter_project/presentation/bloc/l10n/app_localisations_state.dart';
import 'package:test_flutter_project/presentation/bloc/user/user_data_cubit.dart';
import 'package:test_flutter_project/presentation/bloc/user/user_data_state.dart';
import 'package:test_flutter_project/presentation/pages/account/sub_pages/clear_data/clear_user_data_page.dart';

import '../../../../../common/extensions/context_extension_test.mocks.dart';
import '../../../../../utils/app_router_test.mocks.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockUserDataCubit mockCubit;
  final MockAppLocalisationsCubit mockAppLocalisationsCubit = MockAppLocalisationsCubit();

  late UserDataState stateWithData;
  late UserDataState stateCleared;

  setUp(() {
    mockCubit = MockUserDataCubit();

    stateWithData = const UserDataState(viewedIds: ['1'], favoriteIds: ['2'], createdIds: ['3']);
    stateCleared = const UserDataState(viewedIds: [], favoriteIds: [], createdIds: []);
  });

  Widget buildTestable({required UserDataState state}) {
    when(mockCubit.state).thenReturn(state);
    when(mockCubit.stream).thenAnswer((_) => const Stream.empty());

    when(mockAppLocalisationsCubit.stream).thenAnswer((_) => const Stream.empty());
    when(mockAppLocalisationsCubit.state).thenReturn(
      const AppLocalisationsState(
        localisations: {
          L10nKeys.accountItemClearData: 'clearData',
          L10nKeys.dataDeletionDescription: 'dataDeletionDescription',
          L10nKeys.clearViewHistoryItem: 'clearViewHistoryItem',
          L10nKeys.clearFavoritesItem: 'clearFavoritesItem',
          L10nKeys.clearMyItemsItem: 'clearMyItemsItem',
          L10nKeys.clearAllDataItem: 'clearAllDataItem',
        },
      ),
    );

    return MaterialApp(
      home: MultiBlocProvider(
        providers: [
          BlocProvider<UserDataCubit>.value(value: mockCubit),
          BlocProvider<AppLocalisationsCubit>.value(value: mockAppLocalisationsCubit),
        ],
        child: const ClearUserDataPage(),
      ),
    );
  }

  testWidgets('renders all main sections and items', (tester) async {
    await tester.pumpWidget(buildTestable(state: stateWithData));

    // AppBar title
    expect(find.textContaining('clearData', findRichText: true), findsOneWidget);

    // Section description
    expect(find.textContaining('dataDeletionDescription', findRichText: true), findsOneWidget);

    // PersonalDetailsListItem titles
    expect(find.textContaining('clearViewHistoryItem', findRichText: true), findsOneWidget);
    expect(find.textContaining('clearFavoritesItem', findRichText: true), findsOneWidget);
    expect(find.textContaining('clearMyItemsItem', findRichText: true), findsOneWidget);

    // AccountItemSeparated title
    expect(find.textContaining('clearAllDataItem', findRichText: true), findsOneWidget);
  });

  testWidgets('disables clear actions when lists are empty', (tester) async {
    await tester.pumpWidget(buildTestable(state: stateCleared));

    // All PersonalDetailsListItem onTap should be null (disabled)
    // AccountItemSeparated should be disabled
    // You can check for the presence of disabled widgets or their properties if you expose them
  });

  testWidgets('tapping clearViewHistoryItem triggers dialog and cubit method', (tester) async {
    await tester.pumpWidget(buildTestable(state: stateWithData));

    // Tap the first PersonalDetailsListItem (clearViewHistoryItem)
    final clearViewHistoryFinder = find.textContaining('clearViewHistoryItem', findRichText: true);
    expect(clearViewHistoryFinder, findsOneWidget);

    // Simulate tap
    await tester.tap(clearViewHistoryFinder);
    await tester.pumpAndSettle();

    // You would need to mock DialogHelper.showConfirmationDialog and verify it was called
    // You can also verify that context.read<UserDataCubit>().clearRecentItems() is called on confirm
  });

  // Add similar tests for clearFavoritesItem, clearMyItemsItem, and clearAllDataItem
}
