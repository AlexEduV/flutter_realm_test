import 'package:test_futter_project/domain/entities/user_entity.dart';
import 'package:test_futter_project/domain/models/conversation_model.dart';
import 'package:test_futter_project/domain/usecases/users/get_user_by_id_use_case.dart';

import '../usecase.dart';

class ExtractUsersFromConversationUseCase
    extends UseCaseWithParams<ConversationModel, Map<String, UserEntity?>> {
  final GetUserByIdUseCase _getUserByIdUseCase;

  ExtractUsersFromConversationUseCase(this._getUserByIdUseCase);

  @override
  Map<String, UserEntity?> call(ConversationModel conversation) {
    final senderIds = conversation.messages.map((m) => m.senderId).toSet();

    final userMap = <String, UserEntity?>{
      for (final id in senderIds) id: _getUserByIdUseCase.call(id),
    };

    return userMap;
  }
}
