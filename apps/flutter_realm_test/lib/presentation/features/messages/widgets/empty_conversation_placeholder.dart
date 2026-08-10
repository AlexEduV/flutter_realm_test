import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:test_flutter_project/common/extensions/context_extension.dart';

import '../../inbox/inbox_page_identifiers.dart';

class EmptyConversationPlaceholder extends StatelessWidget {
  const EmptyConversationPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        spacing: AppDimensions.minorM,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.forum, color: AppColors.headerColor, size: AppDimensions.majorXL),
          Text(context.tr(InboxPageLocaleKeys.inboxPageEmptyText)),
        ],
      ),
    );
  }
}
