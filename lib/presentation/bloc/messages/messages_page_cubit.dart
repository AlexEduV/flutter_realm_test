import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_futter_project/domain/usecases/gifs/search_gifs_use_case.dart';
import 'package:test_futter_project/presentation/bloc/messages/messages_page_state.dart';

class MessagesPageCubit extends Cubit<MessagesPageState> {
  final SearchGifsUseCase _searchGifsUseCase;

  MessagesPageCubit(this._searchGifsUseCase) : super(const MessagesPageState());

  void setCurrentConversationId(String conversationId) {
    emit(state.copyWith(currentConversationId: conversationId));
  }

  Future<void> updateMessageText(String newText) async {
    emit(state.copyWith(currentMessageText: newText));
  }

  Future<void> updateGifsSearch(String query) async {
    emit(state.copyWith(currentGifSearchText: query));

    //todo: add debouncer for input

    emit(state.copyWith(areGifsLoading: true));
    final gifs = await _searchGifsUseCase.call(query);
    emit(state.copyWith(gifsUrls: gifs, areGifsLoading: false));
  }
}
