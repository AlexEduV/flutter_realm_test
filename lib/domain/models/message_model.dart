import 'package:test_futter_project/common/enums/message_status.dart';

class MessageModel {
  final String senderId;
  final MessageStatus messageStatus;
  final String text;
  final DateTime date;

  MessageModel(this.senderId, this.messageStatus, this.text, this.date);

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
