import 'package:flutter/material.dart';

import '../../../../common/app_dimensions.dart';
import '../../../../common/app_text_styles.dart';
import '../../../../utils/l10n.dart';
import 'account_item.dart';

class AccountItemSeparated extends StatelessWidget {
  final Function() onTap;

  const AccountItemSeparated({required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(AppDimensions.normalM),
      clipBehavior: Clip.antiAlias,
      child: AccountItem(
        text: AppLocalisations.accountItemDeleteAccount,
        textStyle: AppTextStyles.zonaPro14
            .copyWith(fontWeight: FontWeight.w600)
            .copyWith(color: Colors.redAccent),
        onTap: onTap,
        isCentered: true,
      ),
    );
  }
}
