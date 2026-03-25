import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:test_futter_project/domain/entities/gif_entity.dart';
import 'package:test_futter_project/domain/entities/user_entity.dart';
import 'package:test_futter_project/l10n/l10n_keys.dart';
import 'package:test_futter_project/presentation/bloc/home/inbox_page/inbox_page_cubit.dart';
import 'package:test_futter_project/presentation/bloc/l10n/app_localisations_cubit.dart';
import 'package:test_futter_project/presentation/bloc/l10n/app_localisations_state.dart';
import 'package:test_futter_project/presentation/bloc/messages/messages_page_cubit.dart';
import 'package:test_futter_project/presentation/bloc/messages/messages_page_state.dart';
import 'package:test_futter_project/presentation/bloc/user/user_data_cubit.dart';
import 'package:test_futter_project/presentation/widgets/gifs_picker_bottom_sheet.dart';

import '../../common/extensions/context_extension_test.mocks.dart';
import '../../utils/app_router_test.mocks.dart';
import '../pages/messages/messages_page_test.mocks.dart';

void main() {
  Widget buildTestableWidget({
    required MessagesPageCubit messagesCubit,
    required InboxPageCubit inboxCubit,
    required UserDataCubit userCubit,
    required AppLocalisationsCubit appLocalisationsCubit,
    required MessagesPageState state,
  }) {
    return MaterialApp(
      home: MultiBlocProvider(
        providers: [
          BlocProvider<MessagesPageCubit>.value(value: messagesCubit),
          BlocProvider<InboxPageCubit>.value(value: inboxCubit),
          BlocProvider<UserDataCubit>.value(value: userCubit),
          BlocProvider<AppLocalisationsCubit>.value(value: appLocalisationsCubit),
        ],
        child: const Material(child: GifsPickerBottomSheet()),
      ),
    );
  }

  testWidgets('renders text field and trending label', (WidgetTester tester) async {
    final messagesCubit = MockMessagesPageCubit();
    final inboxCubit = MockInboxPageCubit();
    final userCubit = MockUserDataCubit();
    final appLocalisationsCubit = MockAppLocalisationsCubit();

    when(
      messagesCubit.state,
    ).thenReturn(const MessagesPageState(latestQuery: '', gifsInSearch: []));
    when(messagesCubit.stream).thenAnswer((_) => const Stream.empty());
    when(appLocalisationsCubit.stream).thenAnswer((_) => const Stream.empty());
    when(appLocalisationsCubit.state).thenReturn(
      const AppLocalisationsState(localisations: {L10nKeys.gifsResultsTrendingLabel: 'Trending'}),
    );

    await tester.pumpWidget(
      buildTestableWidget(
        messagesCubit: messagesCubit,
        inboxCubit: inboxCubit,
        userCubit: userCubit,
        appLocalisationsCubit: appLocalisationsCubit,
        state: const MessagesPageState(latestQuery: '', gifsInSearch: []),
      ),
    );

    expect(find.byType(TextFormField), findsOneWidget);
    expect(find.textContaining('Trending'), findsOneWidget); // Adjust for your localization
  });

  testWidgets('renders query label when search is not empty', (WidgetTester tester) async {
    final messagesCubit = MockMessagesPageCubit();
    final inboxCubit = MockInboxPageCubit();
    final userCubit = MockUserDataCubit();
    final appLocalisationsCubit = MockAppLocalisationsCubit();

    when(
      messagesCubit.state,
    ).thenReturn(const MessagesPageState(latestQuery: 'cat', gifsInSearch: []));
    when(messagesCubit.stream).thenAnswer((_) => const Stream.empty());
    when(appLocalisationsCubit.stream).thenAnswer((_) => const Stream.empty());
    when(appLocalisationsCubit.state).thenReturn(
      const AppLocalisationsState(
        localisations: {L10nKeys.gifsResultsQueryLabel: 'Search results for '},
      ),
    );

    await tester.pumpWidget(
      buildTestableWidget(
        messagesCubit: messagesCubit,
        inboxCubit: inboxCubit,
        userCubit: userCubit,
        appLocalisationsCubit: appLocalisationsCubit,
        state: const MessagesPageState(latestQuery: 'cat', gifsInSearch: []),
      ),
    );

    expect(find.textContaining('cat'), findsOneWidget);
    expect(
      find.textContaining('Search results for'),
      findsOneWidget,
    ); // Adjust for your localization
  });

  testWidgets('renders GIF grid', (WidgetTester tester) async {
    final messagesCubit = MockMessagesPageCubit();
    final inboxCubit = MockInboxPageCubit();
    final userCubit = MockUserDataCubit();
    final appLocalisationsCubit = MockAppLocalisationsCubit();

    final gif = GifEntity(
      id: '1',
      title: 'Funny Cat',
      previewImageUrl: 'http://preview.com/cat.gif',
      imageUrl: 'http://image.com/cat.gif',
      width: 320.0,
      height: 240.0,
    );

    when(messagesCubit.state).thenReturn(MessagesPageState(latestQuery: '', gifsInSearch: [gif]));
    when(messagesCubit.stream).thenAnswer((_) => const Stream.empty());
    when(appLocalisationsCubit.stream).thenAnswer((_) => const Stream.empty());
    when(appLocalisationsCubit.state).thenReturn(const AppLocalisationsState(localisations: {}));

    await tester.pumpWidget(
      buildTestableWidget(
        messagesCubit: messagesCubit,
        inboxCubit: inboxCubit,
        userCubit: userCubit,
        appLocalisationsCubit: appLocalisationsCubit,
        state: MessagesPageState(latestQuery: '', gifsInSearch: [gif]),
      ),
    );

    expect(find.byType(GridView), findsOneWidget);
    expect(find.byType(InkWell), findsOneWidget);
  });

  testWidgets('tapping a GIF calls sendMessage and updateSelectedGif', (WidgetTester tester) async {
    final messagesCubit = MockMessagesPageCubit();
    final inboxCubit = MockInboxPageCubit();
    final userCubit = MockUserDataCubit();
    final appLocalisationsCubit = MockAppLocalisationsCubit();

    final gif = GifEntity(
      id: '1',
      title: 'Funny Cat',
      previewImageUrl: 'http://preview.com/cat.gif',
      imageUrl: 'http://image.com/cat.gif',
      width: 320.0,
      height: 240.0,
    );

    final user = UserEntity.initial(
      userId: 'u1',
      firstName: 'Alice',
      lastName: 'Smith',
      email: 'alice@mock.com',
      password: '',
    );

    when(messagesCubit.state).thenReturn(
      MessagesPageState(latestQuery: '', gifsInSearch: [gif], currentConversationId: 'c1'),
    );
    when(messagesCubit.stream).thenAnswer((_) => const Stream.empty());
    when(appLocalisationsCubit.stream).thenAnswer((_) => const Stream.empty());
    when(appLocalisationsCubit.state).thenReturn(const AppLocalisationsState(localisations: {}));
    when(userCubit.user).thenReturn(user);

    await tester.pumpWidget(
      buildTestableWidget(
        messagesCubit: messagesCubit,
        inboxCubit: inboxCubit,
        userCubit: userCubit,
        appLocalisationsCubit: appLocalisationsCubit,
        state: MessagesPageState(latestQuery: '', gifsInSearch: [gif], currentConversationId: 'c1'),
      ),
    );

    await tester.tap(find.byType(InkWell));
    await tester.pumpAndSettle();

    verify(inboxCubit.sendMessage('c1', any)).called(1);
    verify(messagesCubit.updateSelectedGif(any)).called(1);
  });

  testWidgets('tapping text field animates scale', (WidgetTester tester) async {
    final messagesCubit = MockMessagesPageCubit();
    final inboxCubit = MockInboxPageCubit();
    final userCubit = MockUserDataCubit();
    final appLocalisationsCubit = MockAppLocalisationsCubit();

    when(
      messagesCubit.state,
    ).thenReturn(const MessagesPageState(latestQuery: '', gifsInSearch: []));
    when(messagesCubit.stream).thenAnswer((_) => const Stream.empty());
    when(appLocalisationsCubit.stream).thenAnswer((_) => const Stream.empty());
    when(appLocalisationsCubit.state).thenReturn(const AppLocalisationsState(localisations: {}));

    await tester.pumpWidget(
      buildTestableWidget(
        messagesCubit: messagesCubit,
        inboxCubit: inboxCubit,
        userCubit: userCubit,
        appLocalisationsCubit: appLocalisationsCubit,
        state: const MessagesPageState(latestQuery: '', gifsInSearch: []),
      ),
    );

    await tester.tap(find.byType(TextFormField));
    await tester.pump(const Duration(milliseconds: 100));
    expect(find.byType(AnimatedScale), findsOneWidget);
  });
}
