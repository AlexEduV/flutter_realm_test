import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mockito/mockito.dart';
import 'package:test_flutter_project/presentation/bloc/messages/messages_page_cubit.dart';
import 'package:test_flutter_project/presentation/bloc/messages/messages_page_state.dart';
import 'package:test_flutter_project/presentation/pages/messages/widgets/chat_input_bar/chat_input_bar.dart';

import '../../../../../common/constants/app_colors.dart';
import '../../../../../common/constants/app_dimensions.dart';
import '../../../../bloc/l10n/app_localisations_cubit.dart';

//todo: interactions, like button presses are not mocked;
class MockMessagesPageCubit extends Mock implements MessagesPageCubit {
  @override
  MessagesPageState get state =>
      const MessagesPageState(isLoading: false, currentMessageText: 'Some text');

  @override
  Stream<MessagesPageState> get stream => const Stream.empty();
}

Widget buildChatInputBarUseCase(BuildContext context) {
  final appLocalisationsCubit = AppLocalisationsCubit()..load({});

  final mockMessagesPageCubit = MockMessagesPageCubit();

  final textController = TextEditingController();
  final focusNode = FocusNode();
  final GlobalKey<AnimatedListState> listKey = GlobalKey();

  return MultiBlocProvider(
    providers: [
      BlocProvider<AppLocalisationsCubit>(create: (_) => appLocalisationsCubit),
      BlocProvider<MessagesPageCubit>(create: (_) => mockMessagesPageCubit),
    ],
    child: Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      body: Padding(
        padding: const EdgeInsets.all(AppDimensions.minorL),
        child: Column(
          spacing: AppDimensions.normalL,
          children: [
            ChatInputBar(
              messageTextController: textController,
              messageFocusNode: focusNode,
              listKey: listKey,
            ),
          ],
        ),
      ),
    ),
  );
}
