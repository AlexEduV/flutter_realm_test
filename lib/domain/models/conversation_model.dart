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

  Map<String, dynamic> toJson() {
    return {
      'conversationId': conversationId,
      'ownerId': ownerId,
      'messages': messages.map((m) => m.toJson()).toList(),
    };
  }

  factory ConversationModel.fromJson(Map<String, dynamic> json) {
    return ConversationModel(
      conversationId: json['conversationId'] as String,
      ownerId: json['ownerId'] as String,
      messages: (json['messages'] as List<dynamic>)
          .map((m) => MessageModel.fromJson(m as Map<String, dynamic>))
          .toList(),
    );
  }
}
