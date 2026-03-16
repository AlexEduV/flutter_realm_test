import '../models/message_model.dart';

abstract class InboxRepository {
  Future<List<MessageModel>> fetchMessages();
}
