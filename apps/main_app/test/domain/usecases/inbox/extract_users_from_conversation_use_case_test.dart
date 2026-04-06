import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test_futter_project/common/enums/message_status.dart';
import 'package:test_futter_project/domain/entities/user_entity.dart';
import 'package:test_futter_project/domain/models/conversation_model.dart';
import 'package:test_futter_project/domain/models/message_model.dart';
import 'package:test_futter_project/domain/usecases/inbox/extract_users_from_conversation_use_case.dart';
import 'package:test_futter_project/domain/usecases/users/get_user_by_id_use_case.dart';

import 'extract_users_from_conversation_use_case_test.mocks.dart';

@GenerateMocks([GetUserByIdUseCase])
void main() {
  late MockGetUserByIdUseCase mockGetUserByIdUseCase;
  late ExtractUsersFromConversationUseCase useCase;

  setUp(() {
    mockGetUserByIdUseCase = MockGetUserByIdUseCase();
    useCase = ExtractUsersFromConversationUseCase(mockGetUserByIdUseCase);
  });

  test('should extract unique senderIds and map to UserEntity', () {
    // Arrange
    final user1 = UserEntity.initial(
      userId: '1',
      firstName: 'Alice',
      lastName: 'Fisher',
      email: 'mock@gmail.com',
      password: 'pass',
    );
    final user2 = UserEntity.initial(
      userId: '2',
      firstName: 'Bob',
      lastName: 'Martin',
      email: 'martin@gmail.com',
      password: 'password',
    );
    final messages = <MessageModel>[
      MessageModel(
        senderId: '1',
        messageStatus: MessageStatus.sent,
        payload: '',
        date: DateTime.now(),
      ),
      MessageModel(
        senderId: '2',
        messageStatus: MessageStatus.sent,
        payload: '',
        date: DateTime.now(),
      ),
      MessageModel(
        senderId: '1',
        messageStatus: MessageStatus.sent,
        payload: '',
        date: DateTime.now(),
      ),
    ];
    final conversation = ConversationModel(messages: messages, conversationId: '1', ownerId: '2');

    when(mockGetUserByIdUseCase.call('1')).thenReturn(user1);
    when(mockGetUserByIdUseCase.call('2')).thenReturn(user2);

    // Act
    final result = useCase.call(conversation);

    // Assert
    expect(result, {'1': user1, '2': user2});
    verify(mockGetUserByIdUseCase.call('1')).called(1);
    verify(mockGetUserByIdUseCase.call('2')).called(1);
    verifyNoMoreInteractions(mockGetUserByIdUseCase);
  });

  test('should return null for userIds not found', () {
    // Arrange
    final messages = [
      MessageModel(
        senderId: '3',
        messageStatus: MessageStatus.sent,
        payload: '',
        date: DateTime.now(),
      ),
    ];
    final conversation = ConversationModel(messages: messages, ownerId: '1', conversationId: '505');

    when(mockGetUserByIdUseCase.call('3')).thenReturn(null);

    // Act
    final result = useCase.call(conversation);

    // Assert
    expect(result, {'3': null});
    verify(mockGetUserByIdUseCase.call('3')).called(1);
    verifyNoMoreInteractions(mockGetUserByIdUseCase);
  });
}

// You may need to adjust ConversationModel to accept messages as a list of _FakeMessage or your actual message class.
