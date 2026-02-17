import 'package:test_futter_project/domain/models/message_model.dart';

abstract class MessagesService {
  Future<List<MessageModel>> fetchMessages();

  void addMessage(MessageModel message);

  void dispose();
}
