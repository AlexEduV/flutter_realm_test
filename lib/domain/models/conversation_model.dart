import 'package:test_futter_project/domain/models/message_model.dart';

class ConversationModel {
  final String conversationId;
  final String ownerId;
  final List<MessageModel> messages;

  ConversationModel({required this.conversationId, required this.ownerId, required this.messages});

  factory ConversationModel.empty() {
    return ConversationModel(conversationId: '', ownerId: '', messages: []);
  }

  ConversationModel copyWith({
    String? conversationId,
    String? ownerId,
    List<MessageModel>? messages,
  }) {
    return ConversationModel(
      conversationId: conversationId ?? this.conversationId,
      ownerId: ownerId ?? this.ownerId,
      messages: messages ?? this.messages,
    );
  }
}
