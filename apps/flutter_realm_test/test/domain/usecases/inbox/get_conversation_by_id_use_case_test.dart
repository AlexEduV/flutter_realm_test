import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:test_flutter_project/domain/models/conversation_model.dart';
import 'package:test_flutter_project/domain/usecases/inbox/get_conversation_by_id_use_case.dart';

import 'fetch_conversations_use_case_test.mocks.dart';

void main() {
  late MockInboxRepository mockRepository;
  late GetConversationByIdUseCase useCase;

  setUp(() {
    mockRepository = MockInboxRepository();
    useCase = GetConversationByIdUseCase(mockRepository);
  });

  test(
    'should call getConversationById on repository with correct id and return ConversationModel',
    () {
      final conversationId = '123';
      final conversation = ConversationModel(
        conversationId: conversationId,
        ownerId: '1',
        messages: [],
      );
      when(mockRepository.getConversationById(conversationId)).thenReturn(conversation);

      final result = useCase.call(conversationId);

      expect(result, equals(conversation));
      verify(mockRepository.getConversationById(conversationId)).called(1);
      verifyNoMoreInteractions(mockRepository);
    },
  );

  test('should return null when repository returns null', () {
    final conversationId = 'not_found';
    when(mockRepository.getConversationById(conversationId)).thenReturn(ConversationModel.empty());

    final result = useCase.call(conversationId);

    expect(result, ConversationModel.empty());
    verify(mockRepository.getConversationById(conversationId)).called(1);
    verifyNoMoreInteractions(mockRepository);
  });
}
