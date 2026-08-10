import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:test_flutter_project/common/extensions/context_extension.dart';

import '../../features/inbox/inbox_page_cubit.dart';
import '../../features/inbox/inbox_page_identifiers.dart';
import '../../pages/account/widgets/account_item_separated.dart';

class InboxItemMenuBottomSheet extends StatelessWidget {
  const InboxItemMenuBottomSheet({required this.conversationId, super.key});

  final String conversationId;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.all(
            AppDimensions.normalS,
          ).copyWith(bottom: AppDimensions.majorS),
          child: AccountItemSeparated(
            title: context.tr(InboxPageLocaleKeys.conversationDialogDeleteItemTitle),
            onTap: () => onDeleteItemTap(context),
          ),
        ),
      ],
    );
  }

  Future<void> onDeleteItemTap(BuildContext context) async {
    await context.read<InboxPageCubit>().deleteConversation(conversationId);

    if (!context.mounted) return;
    context.pop();
  }
}
