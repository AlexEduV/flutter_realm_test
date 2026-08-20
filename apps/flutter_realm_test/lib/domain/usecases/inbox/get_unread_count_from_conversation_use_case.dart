import 'package:test_flutter_project/domain/entities/conversation_entity.dart';
import 'package:test_flutter_project/domain/usecases/usecase.dart';

import '../../../common/enums/message_status.dart';

class GetUnreadCountFromConversationUseCase implements UseCaseWithParams<ConversationEntity, int> {
  GetUnreadCountFromConversationUseCase();

  @override
  int call(ConversationEntity params) {
    final unreadCount = params.messages
        .where(
          (element) =>
              element.senderId == params.ownerId && element.messageStatus == MessageStatus.sent,
        )
        .length;

    return unreadCount;
  }
}
