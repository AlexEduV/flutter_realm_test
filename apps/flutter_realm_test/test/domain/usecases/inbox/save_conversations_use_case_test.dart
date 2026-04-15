import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:test_flutter_project/domain/models/conversation_model.dart';
import 'package:test_flutter_project/domain/usecases/inbox/save_conversations_use_case.dart';

import 'fetch_conversations_use_case_test.mocks.dart';

void main() {
  late MockInboxRepository mockRepository;
  late SaveConversationsUseCase useCase;

  setUp(() {
    mockRepository = MockInboxRepository();
    useCase = SaveConversationsUseCase(mockRepository);
  });

  test('should call saveConversations on repository with correct conversations', () async {
    final conversations = [
      ConversationModel(conversationId: '1', ownerId: 'owner1', messages: []),
      ConversationModel(conversationId: '2', ownerId: 'owner2', messages: []),
    ];
    when(mockRepository.saveConversations(conversations)).thenAnswer((_) async {});

    await useCase.call(conversations);

    verify(mockRepository.saveConversations(conversations)).called(1);
    verifyNoMoreInteractions(mockRepository);
  });
}
