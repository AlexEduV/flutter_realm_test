import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test_flutter_project/domain/models/conversation_model.dart';
import 'package:test_flutter_project/domain/repositories/inbox_repository.dart';
import 'package:test_flutter_project/domain/usecases/inbox/fetch_conversations_use_case.dart';

import 'fetch_conversations_use_case_test.mocks.dart';

@GenerateMocks([InboxRepository])
void main() {
  late MockInboxRepository mockRepository;
  late FetchConversationsUseCase useCase;

  setUp(() {
    mockRepository = MockInboxRepository();
    useCase = FetchConversationsUseCase(mockRepository);
  });

  test(
    'should call fetchConversations on repository and return list of ConversationModel',
    () async {
      final conversations = [
        ConversationModel(conversationId: '1', ownerId: '3', messages: []),
        ConversationModel(conversationId: '2', ownerId: '4', messages: []),
      ];
      when(mockRepository.fetchConversations()).thenAnswer((_) async => conversations);

      final result = await useCase.call();

      expect(result, equals(conversations));
      verify(mockRepository.fetchConversations()).called(1);
      verifyNoMoreInteractions(mockRepository);
    },
  );

  test('should return empty list when repository returns empty list', () async {
    when(mockRepository.fetchConversations()).thenAnswer((_) async => []);

    final result = await useCase.call();

    expect(result, isEmpty);
    verify(mockRepository.fetchConversations()).called(1);
    verifyNoMoreInteractions(mockRepository);
  });
}
