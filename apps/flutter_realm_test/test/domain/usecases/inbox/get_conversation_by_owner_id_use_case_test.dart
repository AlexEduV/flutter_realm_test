import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:test_flutter_project/domain/models/conversation_model.dart';
import 'package:test_flutter_project/domain/usecases/inbox/get_conversation_by_owner_id_use_case.dart';

import 'fetch_conversations_use_case_test.mocks.dart';

void main() {
  late MockInboxRepository mockRepository;
  late GetConversationByOwnerIdUseCase useCase;

  setUp(() {
    mockRepository = MockInboxRepository();
    useCase = GetConversationByOwnerIdUseCase(mockRepository);
  });

  test(
    'should call getConversationByOwnerId on repository with correct ownerId and return ConversationModel',
    () {
      final ownerId = 'owner123';
      final conversation = ConversationModel(
        conversationId: 'conv1',
        ownerId: ownerId,
        messages: [],
      );
      when(mockRepository.getConversationByOwnerId(ownerId)).thenReturn(conversation);

      final result = useCase.call(ownerId);

      expect(result, equals(conversation));
      verify(mockRepository.getConversationByOwnerId(ownerId)).called(1);
      verifyNoMoreInteractions(mockRepository);
    },
  );

  test('should return null when repository returns null', () {
    final ownerId = 'not_found';
    when(mockRepository.getConversationByOwnerId(ownerId)).thenReturn(ConversationModel.empty());

    final result = useCase.call(ownerId);

    expect(result, ConversationModel.empty());
    verify(mockRepository.getConversationByOwnerId(ownerId)).called(1);
    verifyNoMoreInteractions(mockRepository);
  });
}
