import 'package:test_flutter_project/domain/entities/conversation_entity.dart';
import 'package:test_flutter_project/domain/entities/user_entity.dart';
import 'package:test_flutter_project/domain/usecases/users/get_user_by_id_use_case.dart';

import '../usecase.dart';

class ExtractUsersFromConversationUseCase
    extends UseCaseWithParams<ConversationEntity, Map<String, UserEntity?>> {
  ExtractUsersFromConversationUseCase(this._getUserByIdUseCase);

  final GetUserByIdUseCase _getUserByIdUseCase;

  @override
  Map<String, UserEntity?> call(ConversationEntity conversation) {
    final senderIds = conversation.messages.map((m) => m.senderId).toSet();

    final userMap = <String, UserEntity?>{
      for (final id in senderIds) id: _getUserByIdUseCase.call(id),
    };

    return userMap;
  }
}
