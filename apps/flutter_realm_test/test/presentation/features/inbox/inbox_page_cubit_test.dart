import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test_flutter_project/common/enums/message_status.dart';
import 'package:test_flutter_project/domain/entities/conversation_entity.dart';
import 'package:test_flutter_project/domain/models/message_model.dart';
import 'package:test_flutter_project/domain/services/time_service.dart';
import 'package:test_flutter_project/domain/usecases/inbox/fetch_conversations_use_case.dart';
import 'package:test_flutter_project/domain/usecases/inbox/get_unread_count_from_conversation_use_case.dart';
import 'package:test_flutter_project/domain/usecases/inbox/save_conversations_use_case.dart';
import 'package:test_flutter_project/presentation/features/inbox/inbox_page_cubit.dart';
import 'package:test_flutter_project/presentation/features/inbox/inbox_page_state.dart';

import '../../features/inbox/inbox_page_cubit_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<TimeService>(),
  MockSpec<FetchConversationsUseCase>(),
  MockSpec<SaveConversationsUseCase>(),
  MockSpec<GetUnreadCountFromConversationUseCase>(),
])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockTimeService mockTimeService;
  late MockFetchConversationsUseCase mockFetchConversationsUseCase;
  late MockSaveConversationsUseCase mockSaveConversationsUseCase;
  late MockGetUnreadCountFromConversationUseCase mockGetUnreadCountFromConversationUseCase;
  late InboxPageCubit cubit;

  setUp(() {
    mockTimeService = MockTimeService();
    mockFetchConversationsUseCase = MockFetchConversationsUseCase();
    mockSaveConversationsUseCase = MockSaveConversationsUseCase();
    mockGetUnreadCountFromConversationUseCase = MockGetUnreadCountFromConversationUseCase();
    cubit = InboxPageCubit(
      mockTimeService,
      mockFetchConversationsUseCase,
      mockSaveConversationsUseCase,
      mockGetUnreadCountFromConversationUseCase,
    );
  });

  test('initial state is InboxPageState()', () {
    expect(cubit.state, const InboxPageState());
  });

  blocTest<InboxPageCubit, InboxPageState>(
    'init emits state with fetched conversations',
    build: () {
      when(mockFetchConversationsUseCase.call()).thenAnswer(
        (_) async => [
          ConversationEntity(
            conversationId: 'c1',
            ownerId: 'u1',
            messages: [
              MessageModel(
                payload: 'Hello',
                messageStatus: MessageStatus.sent,
                senderId: 'u1',
                date: DateTime(2023, 1, 1),
              ),
            ],
          ),
        ],
      );
      return cubit;
    },
    act: (cubit) => cubit.init(),
    expect: () => [
      const InboxPageState().copyWith(
        conversations: [
          ConversationEntity(
            conversationId: 'c1',
            ownerId: 'u1',
            messages: [
              MessageModel(
                payload: 'Hello',
                messageStatus: MessageStatus.sent,
                senderId: 'u1',
                date: DateTime(2023, 1, 1),
              ),
            ],
          ),
        ],
      ),
    ],
  );

  blocTest<InboxPageCubit, InboxPageState>(
    'sendMessage updates conversation and calls save use case',
    build: () {
      when(mockTimeService.now()).thenReturn(DateTime(2023, 1, 2));
      final conversation = ConversationEntity(
        conversationId: 'c1',
        ownerId: 'u1',
        messages: [
          MessageModel(
            payload: 'Hello',
            messageStatus: MessageStatus.sent,
            senderId: 'u1',
            date: DateTime(2023, 1, 1),
          ),
        ],
      );
      cubit.emit(cubit.state.copyWith(conversations: [conversation]));
      when(mockSaveConversationsUseCase.call(any)).thenAnswer((_) async {});
      return cubit;
    },
    act: (cubit) async {
      await cubit.sendMessage(
        'c1',
        MessageModel(
          payload: 'World',
          messageStatus: MessageStatus.sent,
          senderId: 'u2',
        ),
      );
    },
    expect: () => [
      const InboxPageState().copyWith(
        conversations: [
          ConversationEntity(
            conversationId: 'c1',
            ownerId: 'u1',
            messages: [
              MessageModel(
                payload: 'Hello',
                messageStatus: MessageStatus.sent,
                senderId: 'u1',
                date: DateTime(2023, 1, 1),
              ),
              MessageModel(
                payload: 'World',
                messageStatus: MessageStatus.sent,
                senderId: 'u2',
                date: DateTime(2023, 1, 2),
              ),
            ],
          ),
        ],
      ),
    ],
    verify: (_) {
      verify(mockSaveConversationsUseCase.call(any)).called(1);
    },
  );

  blocTest<InboxPageCubit, InboxPageState>(
    'markMessageAsRead updates message status and calls save use case',
    build: () {
      final conversation = ConversationEntity(
        conversationId: 'c1',
        ownerId: 'u1',
        messages: [
          MessageModel(
            payload: 'Hello',
            messageStatus: MessageStatus.sent,
            senderId: 'u1',
            date: DateTime(2023, 1, 1),
          ),
        ],
      );
      cubit.emit(cubit.state.copyWith(conversations: [conversation]));
      when(mockSaveConversationsUseCase.call(any)).thenAnswer((_) async {});
      return cubit;
    },
    act: (cubit) async {
      await cubit.markMessageAsRead('c1', 0);
    },
    expect: () => [
      const InboxPageState().copyWith(
        conversations: [
          ConversationEntity(
            conversationId: 'c1',
            ownerId: 'u1',
            messages: [
              MessageModel(
                payload: 'Hello',
                messageStatus: MessageStatus.read,
                senderId: 'u1',
                date: DateTime(2023, 1, 1),
              ),
            ],
          ),
        ],
      ),
    ],
    verify: (_) {
      verify(mockSaveConversationsUseCase.call(any)).called(1);
    },
  );

  blocTest<InboxPageCubit, InboxPageState>(
    'deleteConversation removes conversation and calls save use case',
    build: () {
      final conversation1 = ConversationEntity(conversationId: 'c1', ownerId: 'u1', messages: []);
      final conversation2 = ConversationEntity(conversationId: 'c2', ownerId: 'u2', messages: []);
      cubit.emit(cubit.state.copyWith(conversations: [conversation1, conversation2]));
      when(mockSaveConversationsUseCase.call(any)).thenAnswer((_) async {});
      return cubit;
    },
    act: (cubit) async {
      await cubit.deleteConversation('c1');
    },
    expect: () => [
      const InboxPageState().copyWith(
        conversations: [ConversationEntity(conversationId: 'c2', ownerId: 'u2', messages: [])],
      ),
    ],
    verify: (_) {
      verify(mockSaveConversationsUseCase.call(any)).called(1);
    },
  );
}
