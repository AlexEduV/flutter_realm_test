import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test_flutter_project/common/enums/message_status.dart';
import 'package:test_flutter_project/domain/entities/conversation_entity.dart';
import 'package:test_flutter_project/domain/entities/user_entity.dart';
import 'package:test_flutter_project/domain/models/message_model.dart';
import 'package:test_flutter_project/domain/repositories/user_repository.dart';
import 'package:test_flutter_project/domain/usecases/inbox/extract_users_from_conversation_use_case.dart';

import '../../../common/fakes/common_mocks.mocks.dart';

@GenerateNiceMocks([MockSpec<UserRepository>()])
void main() {
  late MockUserRepository mockUserRepository;
  late ExtractUsersFromConversationUseCase useCase;

  setUp(() {
    mockUserRepository = MockUserRepository();
    useCase = ExtractUsersFromConversationUseCase(mockUserRepository);
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
    final conversation = ConversationEntity(messages: messages, conversationId: '1', ownerId: '2');

    when(mockUserRepository.getUserById('1')).thenReturn(user1);
    when(mockUserRepository.getUserById('2')).thenReturn(user2);

    // Act
    final result = useCase.call(conversation);

    // Assert
    expect(result, {'1': user1, '2': user2});
    verify(mockUserRepository.getUserById('1')).called(1);
    verify(mockUserRepository.getUserById('2')).called(1);
    verifyNoMoreInteractions(mockUserRepository);
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
    final conversation = ConversationEntity(
      messages: messages,
      ownerId: '1',
      conversationId: '505',
    );

    when(mockUserRepository.getUserById('3')).thenReturn(null);

    // Act
    final result = useCase.call(conversation);

    // Assert
    expect(result, {'3': null});
    verify(mockUserRepository.getUserById('3')).called(1);
    verifyNoMoreInteractions(mockUserRepository);
  });
}

// You may need to adjust ConversationModel to accept messages as a list of _FakeMessage or your actual message class.
