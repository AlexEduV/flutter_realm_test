import 'package:test_futter_project/common/enums/message_status.dart';
import 'package:test_futter_project/domain/entities/owner_entity.dart';

class MessageModel {
  final OwnerEntity sender;
  final MessageStatus messageStatus;
  final String text;
  final DateTime date;

  MessageModel(this.sender, this.messageStatus, this.text, this.date);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MessageModel &&
          runtimeType == other.runtimeType &&
          sender == other.sender &&
          messageStatus == other.messageStatus &&
          text == other.text &&
          date == other.date;

  @override
  int get hashCode => sender.hashCode ^ messageStatus.hashCode ^ text.hashCode ^ date.hashCode;
}
