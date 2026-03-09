import 'package:flutter/material.dart';

import '../../../../common/app_dimensions.dart';
import '../../../../common/app_text_styles.dart';
import 'account_item.dart';

class AccountItemSeparated extends StatelessWidget {
  final String title;
  final Function()? onTap;
  final bool isEnabled;

  const AccountItemSeparated({
    required this.title,
    required this.onTap,
    this.isEnabled = true,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(AppDimensions.normalM),
      clipBehavior: Clip.antiAlias,
      child: AccountItem(
        text: title,
        textStyle: AppTextStyles.zonaPro14
            .copyWith(fontWeight: FontWeight.w600)
            .copyWith(color: isEnabled ? Colors.redAccent : Colors.grey),
        onTap: onTap,
        isCentered: true,
      ),
    );
  }
}
