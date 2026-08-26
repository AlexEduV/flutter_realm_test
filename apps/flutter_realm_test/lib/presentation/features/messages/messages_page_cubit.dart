import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_flutter_project/domain/entities/attachment_entity.dart';
import 'package:test_flutter_project/domain/entities/owner_entity.dart';
import 'package:test_flutter_project/domain/entities/user_entity.dart';
import 'package:test_flutter_project/domain/usecases/file_picker/pick_attachment_file_use_case.dart';
import 'package:test_flutter_project/domain/usecases/gifs/get_trending_gifs_use_case.dart';
import 'package:test_flutter_project/domain/usecases/gifs/search_gifs_use_case.dart';
import 'package:test_flutter_project/domain/usecases/inbox/extract_users_from_conversation_use_case.dart';
import 'package:test_flutter_project/domain/usecases/inbox/get_conversation_by_id_use_case.dart';
import 'package:test_flutter_project/domain/usecases/owners/get_owner_by_id_use_case.dart';
import 'package:test_flutter_project/utils/date_formatter.dart';

import '../../../domain/entities/conversation_entity.dart';
import 'messages_page_state.dart';

class MessagesPageCubit extends Cubit<MessagesPageState> {
  MessagesPageCubit(
    this._searchGifsUseCase,
    this._getTrendingGifsUseCase,
    this._pickAttachmentFileUseCase,
    this._getConversationByIdUseCase,
    this._getOwnerByIdUseCase,
    this._extractUsersFromConversationUseCase,
    this._dateFormatter,
  ) : super(const MessagesPageState());

  final SearchGifsUseCase _searchGifsUseCase;
  final GetTrendingGifsUseCase _getTrendingGifsUseCase;
  final PickAttachmentFileUseCase _pickAttachmentFileUseCase;
  final GetConversationByIdUseCase _getConversationByIdUseCase;
  final GetOwnerByIdUseCase _getOwnerByIdUseCase;
  final ExtractUsersFromConversationUseCase _extractUsersFromConversationUseCase;
  final DateFormatter _dateFormatter;

  int activeRequestId = 0;

  void setCurrentConversationId(String conversationId) {
    emit(state.copyWith(currentConversationId: conversationId));
  }

  Future<void> updateMessageText(String newText) async {
    emit(state.copyWith(currentMessageText: newText));
  }

  Future<void> updateGifsSearch(String query) async {
    final requestId = ++activeRequestId;

    emit(state.copyWith(currentGifSearchText: query));

    emit(state.copyWith(areGifsLoading: true));
    final gifEntities = query.trim().isEmpty
        ? await _getTrendingGifsUseCase.call()
        : await _searchGifsUseCase.call(query);

    if (requestId != activeRequestId) {
      // A newer search has started, discard this result silently
      return;
    }

    gifEntities.fold(
      (l) {
        emit(state.copyWith(gifsInSearch: [], networkError: l));
      },
      (r) {
        emit(state.copyWith(gifsInSearch: r, networkError: null));
      },
    );

    emit(state.copyWith(areGifsLoading: false, latestQuery: query));
  }

  void updateSelectedGif(String? newGifUrl) {
    emit(state.copyWith(selectedGif: newGifUrl));
  }

  Future<AttachmentEntity?> getAttachmentFile() async {
    final result = await _pickAttachmentFileUseCase.call();
    return result;
  }

  ConversationEntity getConversationById(String conversationId) {
    final conversation = _getConversationByIdUseCase.call(conversationId);
    return conversation;
  }

  OwnerEntity getOwnerById(String ownerId) {
    final owner = _getOwnerByIdUseCase.call(ownerId);
    return owner;
  }

  Map<String, UserEntity?> getUsersFromConversation(ConversationEntity conversation) {
    final users = _extractUsersFromConversationUseCase.call(conversation);
    return users;
  }

  String getMessageDividerDate(DateTime? date) {
    final dividerTime = _dateFormatter.formatMessageDividerDate(date);
    return dividerTime;
  }

  String getMessageTime(DateTime? date) {
    final messageTime = _dateFormatter.formatMessageIncomingTime(date);
    return messageTime;
  }
}
