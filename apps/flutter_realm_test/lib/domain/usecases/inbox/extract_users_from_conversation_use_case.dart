import 'package:test_flutter_project/domain/entities/conversation_entity.dart';
import 'package:test_flutter_project/domain/entities/user_entity.dart';
import 'package:test_flutter_project/domain/repositories/user_repository.dart';

import '../usecase.dart';

class ExtractUsersFromConversationUseCase
    extends UseCaseWithParams<ConversationEntity, Map<String, UserEntity?>> {
  ExtractUsersFromConversationUseCase(this._userRepository);

  final UserRepository _userRepository;

  @override
  Map<String, UserEntity?> call(ConversationEntity conversation) {
    final senderIds = conversation.messages.map((m) => m.senderId).toSet();

    final userMap = <String, UserEntity?>{
      for (final id in senderIds) id: _userRepository.getUserById(id),
    };

    return userMap;
  }
}
