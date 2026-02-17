import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_futter_project/data/data_sources/mock_messages_service.dart';
import 'package:test_futter_project/di/injection_container.dart';
import 'package:test_futter_project/presentation/bloc/home/inbox_page/inbox_page_state.dart';

class InboxPageCubit extends Cubit<InboxPageState> {
  InboxPageCubit() : super(const InboxPageState());

  Future<void> init() async {
    final messagesList = await serviceLocator<MockMessagesService>().fetchMessages();
    emit(state.copyWith(messages: messagesList));
  }
}
