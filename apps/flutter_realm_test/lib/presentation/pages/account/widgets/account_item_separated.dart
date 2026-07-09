import 'package:flutter/material.dart';
import 'package:realm_ui_core/realm_ui_core.dart';

class AccountItemSeparated extends StatelessWidget {
  const AccountItemSeparated({
    required this.title,
    required this.onTap,
    this.isEnabled = true,
    super.key,
  });

  final String title;
  final Function()? onTap;
  final bool isEnabled;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(AppDimensions.normalM),
      clipBehavior: Clip.antiAlias,
      child: AccountItem(
        label: title,
        textStyle: AppTextStyles.zonaPro14
            .copyWith(fontWeight: FontWeight.w600)
            .copyWith(color: isEnabled ? Colors.redAccent : Colors.grey),
        onTap: onTap,
        isCentered: true,
      ),
    );
  }
}
