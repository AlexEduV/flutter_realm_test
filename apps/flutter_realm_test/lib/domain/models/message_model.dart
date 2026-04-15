import 'package:test_flutter_project/common/enums/message_status.dart';

class MessageModel {
  final String senderId;
  final MessageStatus messageStatus;
  final String payload;
  final DateTime date;

  MessageModel({
    required this.senderId,
    required this.messageStatus,
    required this.payload,
    required this.date,
  });

  MessageModel copyWith({
    String? senderId,
    MessageStatus? messageStatus,
    String? payload,
    DateTime? date,
  }) {
    return MessageModel(
      senderId: senderId ?? this.senderId,
      messageStatus: messageStatus ?? this.messageStatus,
      payload: payload ?? this.payload,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'senderId': senderId,
      'messageStatus': messageStatus.name,
      'text': payload,
      'date': date.toIso8601String(),
    };
  }

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      senderId: json['senderId'] as String,
      messageStatus: MessageStatus.values.byName(json['messageStatus'] as String),
      payload: json['text'] as String,
      date: DateTime.parse(json['date'] as String),
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MessageModel &&
          runtimeType == other.runtimeType &&
          senderId == other.senderId &&
          messageStatus == other.messageStatus &&
          payload == other.payload &&
          date == other.date;

  @override
  int get hashCode => senderId.hashCode ^ messageStatus.hashCode ^ payload.hashCode ^ date.hashCode;
}
