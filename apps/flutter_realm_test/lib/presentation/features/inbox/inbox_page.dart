import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_flutter_project/common/extensions/context_extension.dart';
import 'package:test_flutter_project/presentation/features/inbox/inbox_page_cubit.dart';
import 'package:test_flutter_project/presentation/features/inbox/inbox_page_identifiers.dart';
import 'package:test_flutter_project/presentation/features/inbox/inbox_page_state.dart';
import 'package:test_flutter_project/presentation/features/inbox/widgets/inbox_list_item.dart';
import 'package:test_flutter_project/presentation/features/messages/messages_page_cubit.dart';
import 'package:test_flutter_project/presentation/features/user/user_data_cubit.dart';
import 'package:test_flutter_project/presentation/features/user/user_data_state.dart';

class InboxPage extends StatelessWidget {
  const InboxPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.tr(InboxPageLocaleKeys.inboxPageTitle), style: AppTextStyles.zonaPro20),
        centerTitle: true,
      ),
      body: BlocBuilder<UserDataCubit, UserDataState>(
        builder: (context, state) {
          if (!state.isUserAuthenticated) {
            return EmptyResultsPlaceholderWidget(
              text: context.tr(InboxPageLocaleKeys.inboxPageLoggedOutText),
            );
          }

          return BlocBuilder<InboxPageCubit, InboxPageState>(
            builder: (context, state) {
              final items = state.conversations;

              if (state.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state.conversations.isEmpty) {
                return EmptyResultsPlaceholderWidget(
                  text: context.tr(InboxPageLocaleKeys.inboxPageEmptyText),
                );
              }

              return ListView.builder(
                padding: const EdgeInsets.only(top: AppDimensions.normalL),
                itemBuilder: (context, index) {
                  final conversation = state.conversations[index];
                  final unreadCount = context.read<InboxPageCubit>().getUnreadCountFromConversation(
                    conversation,
                  );
                  final owner = context.read<MessagesPageCubit>().getOwnerById(
                    conversation.ownerId,
                  );

                  return InboxListItem(
                    conversation: conversation,
                    unreadCount: unreadCount,
                    owner: owner,
                  );
                },
                itemCount: items.length,
              );
            },
          );
        },
      ),
    );
  }
}
