import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

import '../account_page_identifiers.dart';

class AccountItemSeparated extends StatelessWidget {
  const AccountItemSeparated({
    required this.title,
    required this.onTap,
    this.isEnabled = true,
    super.key,
  });

  final String title;
  final void Function()? onTap;
  final bool isEnabled;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(AppDimensions.normalM),
      clipBehavior: Clip.antiAlias,
      child: AccountItem(
        label: title,
        textStyle: AppTextStyles.zonaPro14.copyWith(
          color: isEnabled ? Colors.redAccent : Colors.grey,
          fontWeight: FontWeight.w600,
        ),
        semanticsId: AccountPageIds.accountItem,
        onTap: onTap,
        isCentered: true,
      ),
    );
  }
}
