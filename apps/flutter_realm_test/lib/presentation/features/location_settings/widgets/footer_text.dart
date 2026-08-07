import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:test_flutter_project/core/di/injection_container.dart';
import 'package:test_flutter_project/domain/usecases/url/open_url_link_use_case.dart';
import 'package:test_flutter_project/presentation/features/location_settings/location_settings_identifiers.dart';

import '../../../widgets/app_semantics.dart';

class FooterText extends StatelessWidget {
  const FooterText({required this.text, this.url, super.key});

  final String text;
  final String? url;

  @override
  Widget build(BuildContext context) {
    final resolvedUrl = url;

    return AppSemantics(
      label: LocationSettingsIds.privacyLinkItem,
      child: InkWell(
        onTap: resolvedUrl != null
            ? () async => await serviceLocator<OpenUrlLinkUseCase>().call(resolvedUrl)
            : null,
        child: Text(text, style: AppTextStyles.zonaPro16Grey.copyWith(fontWeight: FontWeight.w600)),
      ),
    );
  }
}
