import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:test_flutter_project/core/di/injection_container.dart';
import 'package:test_flutter_project/domain/entities/owner_entity.dart';
import 'package:test_flutter_project/domain/entities/user_entity.dart';
import 'package:test_flutter_project/domain/models/conversation_model.dart';
import 'package:test_flutter_project/presentation/bloc/l10n/app_localisations_cubit.dart';
import 'package:test_flutter_project/presentation/bloc/messages/messages_page_cubit.dart';
import 'package:test_flutter_project/presentation/bloc/messages/messages_page_state.dart';
import 'package:test_flutter_project/presentation/bloc/user/user_data_cubit.dart';
import 'package:test_flutter_project/presentation/bloc/user/user_data_state.dart';
import 'package:test_flutter_project/presentation/features/inbox/inbox_page.dart';
import 'package:test_flutter_project/presentation/features/inbox/inbox_page_cubit.dart';
import 'package:test_flutter_project/presentation/features/inbox/inbox_page_state.dart';
import 'package:test_flutter_project/presentation/features/inbox/widgets/inbox_list_item.dart';

import '../../../utils/app_router_test.mocks.dart';
import '../messages/messages_page_test.mocks.dart';

void main() {
  final appLocalisationsCubit = AppLocalisationsCubit();

  Widget buildTestableWidget({
    required UserDataCubit userDataCubit,
    required InboxPageCubit inboxPageCubit,
    MessagesPageCubit? messagesPageCubit,
  }) {
    return MaterialApp(
      home: MultiBlocProvider(
        providers: [
          BlocProvider<AppLocalisationsCubit>.value(value: appLocalisationsCubit),
          BlocProvider<UserDataCubit>.value(value: userDataCubit),
          BlocProvider<InboxPageCubit>.value(value: inboxPageCubit),
          if (messagesPageCubit != null)
            BlocProvider<MessagesPageCubit>.value(value: messagesPageCubit),
        ],
        child: const InboxPage(),
      ),
    );
  }

  setUpAll(() {
    serviceLocator.registerLazySingleton<AppLocalisationsCubit>(() => appLocalisationsCubit);

    final localisations = {'pages.inbox.title': 'Inbox'};
    appLocalisationsCubit.load(localisations);
  });

  tearDownAll(() {
    serviceLocator.unregister<AppLocalisationsCubit>();
  });

  testWidgets('shows app bar title', (WidgetTester tester) async {
    final userDataCubit = MockUserDataCubit();
    final inboxPageCubit = MockInboxPageCubit();

    when(
      userDataCubit.state,
    ).thenReturn(UserDataState(user: UserEntity.empty(), isUserAuthenticated: true));
    when(userDataCubit.stream).thenAnswer((_) => const Stream.empty());

    when(inboxPageCubit.state).thenReturn(const InboxPageState());
    when(inboxPageCubit.stream).thenAnswer((_) => const Stream.empty());

    await tester.pumpWidget(
      buildTestableWidget(userDataCubit: userDataCubit, inboxPageCubit: inboxPageCubit),
    );

    expect(
      find.textContaining('Inbox'),
      findsOneWidget,
    ); // Adjust if your localization is different
  });

  testWidgets('shows logged out placeholder when user is not authenticated', (
    WidgetTester tester,
  ) async {
    final userDataCubit = MockUserDataCubit();
    final inboxPageCubit = MockInboxPageCubit();

    when(
      userDataCubit.state,
    ).thenReturn(UserDataState(user: UserEntity.empty(), isUserAuthenticated: false));
    when(userDataCubit.stream).thenAnswer((_) => const Stream.empty());

    when(inboxPageCubit.state).thenReturn(const InboxPageState());
    when(inboxPageCubit.stream).thenAnswer((_) => const Stream.empty());

    await tester.pumpWidget(
      buildTestableWidget(userDataCubit: userDataCubit, inboxPageCubit: inboxPageCubit),
    );

    expect(find.byType(EmptyResultsPlaceholderWidget), findsOneWidget);
  });

  testWidgets('shows loading indicator when loading', (WidgetTester tester) async {
    final userDataCubit = MockUserDataCubit();
    final inboxPageCubit = MockInboxPageCubit();

    when(
      userDataCubit.state,
    ).thenReturn(UserDataState(user: UserEntity.empty(), isUserAuthenticated: true));
    when(userDataCubit.stream).thenAnswer((_) => const Stream.empty());

    when(inboxPageCubit.state).thenReturn(const InboxPageState(isLoading: true));
    when(inboxPageCubit.stream).thenAnswer((_) => const Stream.empty());

    await tester.pumpWidget(
      buildTestableWidget(userDataCubit: userDataCubit, inboxPageCubit: inboxPageCubit),
    );

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('shows empty placeholder when there are no conversations', (
    WidgetTester tester,
  ) async {
    final userDataCubit = MockUserDataCubit();
    final inboxPageCubit = MockInboxPageCubit();

    when(
      userDataCubit.state,
    ).thenReturn(UserDataState(user: UserEntity.empty(), isUserAuthenticated: true));
    when(userDataCubit.stream).thenAnswer((_) => const Stream.empty());

    when(inboxPageCubit.state).thenReturn(const InboxPageState(conversations: []));
    when(inboxPageCubit.stream).thenAnswer((_) => const Stream.empty());

    await tester.pumpWidget(
      buildTestableWidget(userDataCubit: userDataCubit, inboxPageCubit: inboxPageCubit),
    );

    expect(find.byType(EmptyResultsPlaceholderWidget), findsOneWidget);
  });

  testWidgets('shows list of conversations when present', (WidgetTester tester) async {
    final userDataCubit = MockUserDataCubit();
    final inboxPageCubit = MockInboxPageCubit();
    final messagesPageCubit = MockMessagesPageCubit();

    final conversation = ConversationModel.empty();

    when(
      userDataCubit.state,
    ).thenReturn(UserDataState(user: UserEntity.empty(), isUserAuthenticated: true));
    when(userDataCubit.stream).thenAnswer((_) => const Stream.empty());

    when(inboxPageCubit.state).thenReturn(InboxPageState(conversations: [conversation]));
    when(inboxPageCubit.stream).thenAnswer((_) => const Stream.empty());

    when(messagesPageCubit.state).thenReturn(const MessagesPageState());
    when(messagesPageCubit.stream).thenAnswer((_) => const Stream.empty());
    when(messagesPageCubit.getOwnerById(any)).thenReturn(OwnerEntity.empty());

    await tester.pumpWidget(
      buildTestableWidget(
        userDataCubit: userDataCubit,
        inboxPageCubit: inboxPageCubit,
        messagesPageCubit: messagesPageCubit,
      ),
    );

    expect(find.byType(InboxListItem), findsOneWidget);
  });
}
