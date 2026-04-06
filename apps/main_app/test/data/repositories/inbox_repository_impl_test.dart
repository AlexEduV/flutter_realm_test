import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test_futter_project/data/repositories/inbox_repository_impl.dart';
import 'package:test_futter_project/domain/data_sources/remote/messages_remote_data_source.dart';
import 'package:test_futter_project/domain/models/conversation_model.dart';

import 'inbox_repository_impl_test.mocks.dart';

@GenerateMocks([MessagesRemoteDataSource])
void main() {
  late MockMessagesRemoteDataSource mockRemoteDataSource;
  late InboxRepositoryImpl repository;

  setUp(() {
    mockRemoteDataSource = MockMessagesRemoteDataSource();
    repository = InboxRepositoryImpl(mockRemoteDataSource);
  });

  test('fetchConversations calls remote data source and returns conversations', () async {
    final conversations = [
      ConversationModel(conversationId: 'c1', ownerId: 'o1', messages: []),
      ConversationModel(conversationId: 'c2', ownerId: 'o2', messages: []),
    ];
    when(mockRemoteDataSource.loadConversations()).thenAnswer((_) async => conversations);

    final result = await repository.fetchConversations();

    expect(result, conversations);
    verify(mockRemoteDataSource.loadConversations()).called(1);
    verifyNoMoreInteractions(mockRemoteDataSource);
  });

  test('getConversationById calls remote data source and returns conversation', () {
    final conversation = ConversationModel(conversationId: 'c1', ownerId: 'o1', messages: []);
    when(mockRemoteDataSource.getConversationById('c1')).thenReturn(conversation);

    final result = repository.getConversationById('c1');

    expect(result, conversation);
    verify(mockRemoteDataSource.getConversationById('c1')).called(1);
    verifyNoMoreInteractions(mockRemoteDataSource);
  });

  test('saveConversations calls remote data source with correct parameter', () async {
    final conversations = [ConversationModel(conversationId: 'c1', ownerId: 'o1', messages: [])];
    when(mockRemoteDataSource.saveConversations(conversations)).thenAnswer((_) async {});

    await repository.saveConversations(conversations);

    verify(mockRemoteDataSource.saveConversations(conversations)).called(1);
    verifyNoMoreInteractions(mockRemoteDataSource);
  });

  test('getConversationByOwnerId calls remote data source and returns conversation', () {
    final conversation = ConversationModel(conversationId: 'c2', ownerId: 'o2', messages: []);
    when(mockRemoteDataSource.getConversationByOwnerId('o2')).thenReturn(conversation);

    final result = repository.getConversationByOwnerId('o2');

    expect(result, conversation);
    verify(mockRemoteDataSource.getConversationByOwnerId('o2')).called(1);
    verifyNoMoreInteractions(mockRemoteDataSource);
  });
}
