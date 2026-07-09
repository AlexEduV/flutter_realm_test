import 'package:flutter/material.dart';
import 'package:realm_ui_core/realm_ui_core.dart';
import 'package:test_flutter_project/common/extensions/context_extension.dart';

import '../../../../l10n/l10n_keys.dart';

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
          Text(context.tr(L10nKeys.inboxPageEmptyText)),
        ],
      ),
    );
  }
}
