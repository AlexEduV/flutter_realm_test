import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_futter_project/domain/usecases/inbox/fetch_messages_use_case.dart';
import 'package:test_futter_project/presentation/bloc/home/inbox_page/inbox_page_state.dart';

class InboxPageCubit extends Cubit<InboxPageState> {
  final FetchMessagesUseCase _fetchMessagesUseCase;

  InboxPageCubit(this._fetchMessagesUseCase) : super(const InboxPageState());

  Future<void> init() async {
    final conversationsList = await _fetchMessagesUseCase.call();
    emit(state.copyWith(conversations: conversationsList));
  }
}
