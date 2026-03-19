import 'package:test_futter_project/common/enums/message_status.dart';

class MessageModel {
  final String senderId;
  final MessageStatus messageStatus;
  final String text;
  final DateTime date;

  MessageModel(this.senderId, this.messageStatus, this.text, this.date);

  MessageModel copyWith({
    String? senderId,
    MessageStatus? messageStatus,
    String? text,
    DateTime? date,
  }) {
    return MessageModel(
      senderId ?? this.senderId,
      messageStatus ?? this.messageStatus,
      text ?? this.text,
      date ?? this.date,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'senderId': senderId,
      'messageStatus': messageStatus.name, // Dart 2.15+ .name for enum to String
      'text': text,
      'date': date.toIso8601String(),
    };
  }

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      json['senderId'] as String,
      MessageStatus.values.byName(json['messageStatus'] as String),
      json['text'] as String,
      DateTime.parse(json['date'] as String),
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MessageModel &&
          runtimeType == other.runtimeType &&
          senderId == other.senderId &&
          messageStatus == other.messageStatus &&
          text == other.text &&
          date == other.date;

  @override
  int get hashCode => senderId.hashCode ^ messageStatus.hashCode ^ text.hashCode ^ date.hashCode;
}
