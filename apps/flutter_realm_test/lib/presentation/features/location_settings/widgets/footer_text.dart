import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:test_flutter_project/presentation/features/location_settings/location_settings_identifiers.dart';

import '../../../widgets/app_semantics.dart';

class FooterText extends StatelessWidget {
  const FooterText({required this.text, this.onTap, super.key});

  final String text;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return AppSemantics(
      label: LocationSettingsIds.privacyLinkItem,
      child: InkWell(
        onTap: onTap,
        child: Text(text, style: AppTextStyles.zonaPro16Grey.copyWith(fontWeight: FontWeight.w600)),
      ),
    );
  }
}
