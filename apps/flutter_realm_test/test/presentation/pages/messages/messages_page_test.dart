import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test_flutter_project/common/enums/message_status.dart';
import 'package:test_flutter_project/domain/entities/owner_entity.dart';
import 'package:test_flutter_project/domain/entities/user_entity.dart';
import 'package:test_flutter_project/domain/models/conversation_model.dart';
import 'package:test_flutter_project/domain/models/message_model.dart';
import 'package:test_flutter_project/presentation/features/inbox/inbox_page_cubit.dart';
import 'package:test_flutter_project/presentation/features/inbox/inbox_page_state.dart';
import 'package:test_flutter_project/presentation/features/l10n/app_localisations_cubit.dart';
import 'package:test_flutter_project/presentation/features/messages/messages_page.dart';
import 'package:test_flutter_project/presentation/features/messages/messages_page_cubit.dart';
import 'package:test_flutter_project/presentation/features/messages/messages_page_state.dart';
import 'package:test_flutter_project/presentation/features/messages/widgets/chat_input_bar/chat_input_bar.dart';
import 'package:test_flutter_project/presentation/features/messages/widgets/empty_conversation_placeholder.dart';
import 'package:test_flutter_project/presentation/features/messages/widgets/message_item/message_item.dart';
import 'package:test_flutter_project/presentation/widgets/avatar_widget.dart';
import 'package:visibility_detector/visibility_detector.dart';

import 'messages_page_test.mocks.dart';

@GenerateNiceMocks([MockSpec<InboxPageCubit>(), MockSpec<MessagesPageCubit>()])
void main() {
  final appLocalisationsCubit = AppLocalisationsCubit();

  setUp(() {
    VisibilityDetectorController.instance.updateInterval = Duration.zero;
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

    when(cubit.state).thenReturn(const InboxPageState());
    when(cubit.stream).thenAnswer((_) => const Stream.empty());

    final messagesPageCubit = MockMessagesPageCubit();
    when(messagesPageCubit.state).thenReturn(const MessagesPageState());
    when(messagesPageCubit.stream).thenAnswer((_) => const Stream.empty());
    when(messagesPageCubit.getConversationById('c1')).thenReturn(conversation);
    when(messagesPageCubit.getOwnerById('o1')).thenReturn(owner);
    when(messagesPageCubit.getUsersFromConversation(conversation)).thenReturn({});

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

    when(cubit.state).thenReturn(const InboxPageState());
    when(cubit.stream).thenAnswer((_) => const Stream.empty());

    final messagesPageCubit = MockMessagesPageCubit();
    when(messagesPageCubit.state).thenReturn(const MessagesPageState());
    when(messagesPageCubit.stream).thenAnswer((_) => const Stream.empty());
    when(messagesPageCubit.getConversationById('c1')).thenReturn(conversation);
    when(messagesPageCubit.getOwnerById('o1')).thenReturn(owner);
    when(messagesPageCubit.getUsersFromConversation(conversation)).thenReturn({
      'u1': UserEntity.initial(
        userId: 'u1',
        firstName: 'Alice',
        lastName: 'Smith',
        email: 'alice@mock.com',
        password: '',
      ),
    });

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
    final users = {
      'u1': UserEntity.initial(
        userId: 'u1',
        firstName: 'Alice',
        lastName: 'Smith',
        email: 'alice@mock.com',
        password: '',
      ),
    };
    final cubit = MockInboxPageCubit();

    when(cubit.state).thenReturn(const InboxPageState());
    when(cubit.stream).thenAnswer((_) => const Stream.empty());

    final messagesPageCubit = MockMessagesPageCubit();
    when(messagesPageCubit.state).thenReturn(const MessagesPageState());
    when(messagesPageCubit.stream).thenAnswer((_) => const Stream.empty());
    when(messagesPageCubit.getConversationById('c1')).thenReturn(conversation);
    when(messagesPageCubit.getOwnerById('o1')).thenReturn(owner);
    when(messagesPageCubit.getUsersFromConversation(conversation)).thenReturn(users);
    when(messagesPageCubit.getMessageDividerDate(any)).thenReturn('Today');
    when(messagesPageCubit.getMessageTime(any)).thenReturn('12:00');

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

    when(cubit.state).thenReturn(const InboxPageState());
    when(cubit.stream).thenAnswer((_) => const Stream.empty());

    final messagesPageCubit = MockMessagesPageCubit();
    when(messagesPageCubit.state).thenReturn(const MessagesPageState());
    when(messagesPageCubit.stream).thenAnswer((_) => const Stream.empty());
    when(messagesPageCubit.getConversationById('c1')).thenReturn(conversation);
    when(messagesPageCubit.getOwnerById('o1')).thenReturn(owner);
    when(messagesPageCubit.getUsersFromConversation(conversation)).thenReturn({
      'u1': UserEntity.initial(
        userId: 'u1',
        firstName: 'Alice',
        lastName: 'Smith',
        email: 'alice@mock.com',
        password: '',
      ),
    });

    await tester.pumpWidget(
      buildTestableWidget(conversationId: 'c1', cubit: cubit, messagesCubit: messagesPageCubit),
    );
    await tester.pumpAndSettle();

    expect(find.byType(ChatInputBar), findsOneWidget);
  });
}
