import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:test_futter_project/domain/models/conversation_model.dart';

part 'inbox_page_state.freezed.dart';

@freezed
abstract class InboxPageState with _$InboxPageState {
  const factory InboxPageState({
    @Default([]) List<ConversationModel> conversations,
    @Default(false) bool isLoading,
  }) = _InboxPageState;
}
