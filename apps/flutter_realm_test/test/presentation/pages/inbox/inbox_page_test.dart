import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:test_flutter_project/core/di/injection_container.dart';
import 'package:test_flutter_project/domain/entities/owner_entity.dart';
import 'package:test_flutter_project/domain/models/conversation_model.dart';
import 'package:test_flutter_project/domain/usecases/owners/get_owner_by_id_use_case.dart';
import 'package:test_flutter_project/presentation/bloc/home/inbox_page/inbox_page_cubit.dart';
import 'package:test_flutter_project/presentation/bloc/home/inbox_page/inbox_page_state.dart';
import 'package:test_flutter_project/presentation/bloc/l10n/app_localisations_cubit.dart';
import 'package:test_flutter_project/presentation/bloc/user/user_data_cubit.dart';
import 'package:test_flutter_project/presentation/bloc/user/user_data_state.dart';
import 'package:test_flutter_project/presentation/pages/home/inbox_page/inbox_page.dart';
import 'package:test_flutter_project/presentation/pages/home/inbox_page/widgets/inbox_list_item.dart';
import 'package:test_flutter_project/presentation/pages/search/widgets/empty_search_placeholder_widget.dart';

import '../../../utils/app_router_test.mocks.dart';
import '../messages/messages_page_test.mocks.dart';

void main() {
  final appLocalisationsCubit = AppLocalisationsCubit();
  final mockGetOwnerByIdUseCase = MockGetOwnerByIdUseCase();

  Widget buildTestableWidget({
    required UserDataCubit userDataCubit,
    required InboxPageCubit inboxPageCubit,
  }) {
    return MaterialApp(
      home: MultiBlocProvider(
        providers: [
          BlocProvider<AppLocalisationsCubit>.value(value: appLocalisationsCubit),
          BlocProvider<UserDataCubit>.value(value: userDataCubit),
          BlocProvider<InboxPageCubit>.value(value: inboxPageCubit),
        ],
        child: const InboxPage(),
      ),
    );
  }

  setUpAll(() {
    serviceLocator.registerLazySingleton<AppLocalisationsCubit>(() => appLocalisationsCubit);
    serviceLocator.registerLazySingleton<GetOwnerByIdUseCase>(() => mockGetOwnerByIdUseCase);

    final localisations = {'pages.inbox.title': 'Inbox'};
    appLocalisationsCubit.load(localisations);
  });

  tearDownAll(() {
    serviceLocator.unregister<AppLocalisationsCubit>();
  });

  testWidgets('shows app bar title', (WidgetTester tester) async {
    final userDataCubit = MockUserDataCubit();
    final inboxPageCubit = MockInboxPageCubit();

    when(userDataCubit.state).thenReturn(const UserDataState(isUserAuthenticated: true));
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

    when(userDataCubit.state).thenReturn(const UserDataState(isUserAuthenticated: false));
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

    when(userDataCubit.state).thenReturn(const UserDataState(isUserAuthenticated: true));
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

    when(userDataCubit.state).thenReturn(const UserDataState(isUserAuthenticated: true));
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

    // Replace with your actual ConversationModel
    final conversation = ConversationModel.empty();

    when(userDataCubit.state).thenReturn(const UserDataState(isUserAuthenticated: true));
    when(userDataCubit.stream).thenAnswer((_) => const Stream.empty());

    when(inboxPageCubit.state).thenReturn(InboxPageState(conversations: [conversation]));
    when(inboxPageCubit.stream).thenAnswer((_) => const Stream.empty());

    when(mockGetOwnerByIdUseCase.call('')).thenReturn(OwnerEntity.empty());

    await tester.pumpWidget(
      buildTestableWidget(userDataCubit: userDataCubit, inboxPageCubit: inboxPageCubit),
    );

    expect(find.byType(InboxListItem), findsOneWidget);
  });
}
