import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_futter_project/domain/usecases/gifs/search_gifs_use_case.dart';
import 'package:test_futter_project/presentation/bloc/messages/messages_page_state.dart';

class MessagesPageCubit extends Cubit<MessagesPageState> {
  final SearchGifsUseCase _searchGifsUseCase;

  MessagesPageCubit(this._searchGifsUseCase) : super(const MessagesPageState());

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
    final gifs = await _searchGifsUseCase.call(query);

    if (requestId != activeRequestId) {
      // A newer search has started, discard this result silently
      return;
    }

    emit(state.copyWith(gifsUrls: gifs, areGifsLoading: false, latestQuery: query));
  }
}
