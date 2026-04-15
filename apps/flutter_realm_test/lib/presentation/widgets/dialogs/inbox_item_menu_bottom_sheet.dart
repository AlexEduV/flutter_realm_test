import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:test_flutter_project/common/extensions/context_extension.dart';

import '../../../common/constants/app_dimensions.dart';
import '../../../l10n/l10n_keys.dart';
import '../../bloc/home/inbox_page/inbox_page_cubit.dart';
import '../../pages/account/widgets/account_item_separated.dart';

class InboxItemMenuBottomSheet extends StatelessWidget {
  final String conversationId;

  const InboxItemMenuBottomSheet({required this.conversationId, super.key});

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
            title: context.tr(L10nKeys.conversationDialogDeleteItemTitle),
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
