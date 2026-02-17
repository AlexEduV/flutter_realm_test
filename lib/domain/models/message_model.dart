import 'package:test_futter_project/common/enums/message_status.dart';

class MessageModel {
  final String sender;
  final MessageStatus messageStatus;
  final String message;
  final DateTime date;

  MessageModel(this.sender, this.messageStatus, this.message, this.date);
}
