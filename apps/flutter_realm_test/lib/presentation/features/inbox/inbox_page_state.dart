import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:test_flutter_project/domain/entities/conversation_entity.dart';

part 'inbox_page_state.freezed.dart';

@freezed
abstract class InboxPageState with _$InboxPageState {
  const factory InboxPageState({
    @Default(false) bool isLoading,
    @Default([]) List<ConversationEntity> conversations,
  }) = _InboxPageState;
}
