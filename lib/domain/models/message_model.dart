import 'package:test_futter_project/common/enums/message_status.dart';
import 'package:test_futter_project/domain/models/owner_model.dart';

class MessageModel {
  final OwnerModel sender;
  final MessageStatus messageStatus;
  final String message;
  final DateTime date;

  MessageModel(this.sender, this.messageStatus, this.message, this.date);
}
