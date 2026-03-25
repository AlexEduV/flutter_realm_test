import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test_futter_project/common/enums/message_status.dart';
import 'package:test_futter_project/domain/entities/owner_entity.dart';
import 'package:test_futter_project/domain/entities/user_entity.dart';
import 'package:test_futter_project/domain/models/conversation_model.dart';
import 'package:test_futter_project/domain/models/message_model.dart';
import 'package:test_futter_project/domain/usecases/inbox/extract_users_from_conversation_use_case.dart';
import 'package:test_futter_project/domain/usecases/inbox/get_conversation_by_id_use_case.dart';
import 'package:test_futter_project/domain/usecases/owners/get_owner_by_id_use_case.dart';
import 'package:test_futter_project/domain/usecases/users/get_user_by_id_use_case.dart';
import 'package:test_futter_project/presentation/bloc/home/inbox_page/inbox_page_cubit.dart';
import 'package:test_futter_project/presentation/bloc/home/inbox_page/inbox_page_state.dart';
import 'package:test_futter_project/presentation/bloc/l10n/app_localisations_cubit.dart';
import 'package:test_futter_project/presentation/bloc/messages/messages_page_cubit.dart';
import 'package:test_futter_project/presentation/bloc/messages/messages_page_state.dart';
import 'package:test_futter_project/presentation/pages/messages/messages_page.dart';
import 'package:test_futter_project/presentation/pages/messages/widgets/chat_input_bar/chat_input_bar.dart';
import 'package:test_futter_project/presentation/pages/messages/widgets/empty_conversation_placeholder.dart';
import 'package:test_futter_project/presentation/pages/messages/widgets/message_item/message_item.dart';
import 'package:test_futter_project/presentation/widgets/avatar_widget.dart';

import 'messages_page_test.mocks.dart';

final getIt = GetIt.instance;

@GenerateMocks([
  GetConversationByIdUseCase,
  GetOwnerByIdUseCase,
  ExtractUsersFromConversationUseCase,
  GetUserByIdUseCase,
  InboxPageCubit,
  MessagesPageCubit,
])
void main() {
  final appLocalisationsCubit = AppLocalisationsCubit();

  setUp(() {
    getIt.reset();
    getIt.registerSingleton<GetConversationByIdUseCase>(MockGetConversationByIdUseCase());
    getIt.registerSingleton<AppLocalisationsCubit>(appLocalisationsCubit);
    getIt.registerSingleton<GetOwnerByIdUseCase>(MockGetOwnerByIdUseCase());
    getIt.registerSingleton<ExtractUsersFromConversationUseCase>(
      MockExtractUsersFromConversationUseCase(),
    );
    getIt.registerSingleton<GetUserByIdUseCase>(MockGetUserByIdUseCase());
  });

  Widget buildTestableWidget({
    required String conversationId,
    required InboxPageCubit cubit,
    required MessagesPageCubit messagesCubit,
  }) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<InboxPageCubit>.value(value: cubit),
        BlocProvider<MessagesPageCubit>.value(value: messagesCubit),
        BlocProvider<AppLocalisationsCubit>.value(value: appLocalisationsCubit),
      ],
      child: MaterialApp(home: MessagesPage(conversationId: conversationId)),
    );
  }

  testWidgets('displays app bar with owner name and avatar', (WidgetTester tester) async {
    final owner = OwnerEntity(id: 'o1', firstName: 'John', lastName: 'Doe', linkedItemIds: []);
    final conversation = ConversationModel(conversationId: 'c1', ownerId: 'o1', messages: []);
    final cubit = MockInboxPageCubit();

    when(getIt<GetConversationByIdUseCase>().call('c1')).thenReturn(conversation);
    when(getIt<GetOwnerByIdUseCase>().call('o1')).thenReturn(owner);
    when(getIt<ExtractUsersFromConversationUseCase>().call(conversation)).thenReturn({});
    when(cubit.state).thenReturn(const InboxPageState());
    when(cubit.stream).thenAnswer((_) => const Stream.empty());

    final messagesPageCubit = MockMessagesPageCubit();
    when(messagesPageCubit.state).thenReturn(const MessagesPageState());
    when(messagesPageCubit.stream).thenAnswer((_) => const Stream.empty());

    await tester.pumpWidget(
      buildTestableWidget(conversationId: 'c1', cubit: cubit, messagesCubit: messagesPageCubit),
    );
    await tester.pumpAndSettle();

    expect(find.text('John Doe'), findsOneWidget);
    expect(find.byType(AvatarWidget), findsOneWidget);
  });

  testWidgets('shows EmptyConversationPlaceholder when no messages', (WidgetTester tester) async {
    final owner = OwnerEntity(id: 'o1', firstName: 'John', lastName: 'Doe', linkedItemIds: []);
    final conversation = ConversationModel(conversationId: 'c1', ownerId: 'o1', messages: []);
    final cubit = MockInboxPageCubit();

    when(getIt<GetConversationByIdUseCase>().call('c1')).thenReturn(conversation);
    when(getIt<GetOwnerByIdUseCase>().call('o1')).thenReturn(owner);
    when(cubit.state).thenReturn(const InboxPageState());
    when(getIt<ExtractUsersFromConversationUseCase>().call(conversation)).thenReturn({
      'u1': UserEntity.initial(
        userId: 'u1',
        firstName: 'Alice',
        lastName: 'Smith',
        email: 'alice@mock.com',
        password: '',
      ),
    });
    when(cubit.stream).thenAnswer((_) => const Stream.empty());

    final messagesPageCubit = MockMessagesPageCubit();
    when(messagesPageCubit.state).thenReturn(const MessagesPageState());
    when(messagesPageCubit.stream).thenAnswer((_) => const Stream.empty());

    await tester.pumpWidget(
      buildTestableWidget(conversationId: 'c1', cubit: cubit, messagesCubit: messagesPageCubit),
    );
    await tester.pumpAndSettle();

    expect(find.byType(EmptyConversationPlaceholder), findsOneWidget);
  });

  testWidgets('shows a list of messages when present', (WidgetTester tester) async {
    final owner = OwnerEntity(id: 'o1', firstName: 'John', lastName: 'Doe', linkedItemIds: []);
    final message = MessageModel(
      senderId: 'u1',
      messageStatus: MessageStatus.sent,
      payload: 'Hello!',
      date: DateTime.now(),
    );
    final conversation = ConversationModel(
      conversationId: 'c1',
      ownerId: 'o1',
      messages: [message],
    );
    final cubit = MockInboxPageCubit();

    when(getIt<GetConversationByIdUseCase>().call('c1')).thenReturn(conversation);
    when(getIt<GetOwnerByIdUseCase>().call('o1')).thenReturn(owner);
    when(cubit.state).thenReturn(const InboxPageState());
    when(cubit.stream).thenAnswer((_) => const Stream.empty());

    when(getIt<ExtractUsersFromConversationUseCase>().call(conversation)).thenReturn({
      'u1': UserEntity.initial(
        userId: 'u1',
        firstName: 'Alice',
        lastName: 'Smith',
        email: 'alice@mock.com',
        password: '',
      ),
    });

    final messagesPageCubit = MockMessagesPageCubit();
    when(messagesPageCubit.state).thenReturn(const MessagesPageState());
    when(messagesPageCubit.stream).thenAnswer((_) => const Stream.empty());

    await tester.pumpWidget(
      buildTestableWidget(conversationId: 'c1', cubit: cubit, messagesCubit: messagesPageCubit),
    );
    await tester.pumpAndSettle();

    expect(find.byType(MessageItem), findsOneWidget);
    expect(find.text('Hello!'), findsOneWidget);
  });

  testWidgets('shows ChatInputBar at the bottom', (WidgetTester tester) async {
    final owner = OwnerEntity(id: 'o1', firstName: 'John', lastName: 'Doe', linkedItemIds: []);
    final conversation = ConversationModel(conversationId: 'c1', ownerId: 'o1', messages: []);
    final cubit = MockInboxPageCubit();

    when(getIt<GetConversationByIdUseCase>().call('c1')).thenReturn(conversation);
    when(getIt<GetOwnerByIdUseCase>().call('o1')).thenReturn(owner);
    when(getIt<ExtractUsersFromConversationUseCase>().call(conversation)).thenReturn({
      'u1': UserEntity.initial(
        userId: 'u1',
        firstName: 'Alice',
        lastName: 'Smith',
        email: 'alice@mock.com',
        password: '',
      ),
    });
    when(cubit.state).thenReturn(const InboxPageState());
    when(cubit.stream).thenAnswer((_) => const Stream.empty());

    final messagesPageCubit = MockMessagesPageCubit();
    when(messagesPageCubit.state).thenReturn(const MessagesPageState());
    when(messagesPageCubit.stream).thenAnswer((_) => const Stream.empty());

    await tester.pumpWidget(
      buildTestableWidget(conversationId: 'c1', cubit: cubit, messagesCubit: messagesPageCubit),
    );
    await tester.pumpAndSettle();

    expect(find.byType(ChatInputBar), findsOneWidget);
  });
}
