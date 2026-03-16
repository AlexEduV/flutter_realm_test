import 'package:flutter/material.dart';
import 'package:test_futter_project/common/app_semantics_labels.dart';
import 'package:test_futter_project/di/injection_container.dart';
import 'package:test_futter_project/domain/data_sources/local/url_launch_local_data_source.dart';

import '../../../../../../common/app_text_styles.dart';
import '../../../../../widgets/app_semantics.dart';

class FooterText extends StatelessWidget {
  final String text;
  final String? url;

  const FooterText({required this.text, this.url, super.key});

  @override
  Widget build(BuildContext context) {
    return AppSemantics(
      label: AppSemanticsLabels.privacyLinkItem,
      child: InkWell(
        onTap: url != null
            ? () async => await serviceLocator<UrlLaunchLocalDataSource>().openUrl(url)
            : null,
        child: Text(text, style: AppTextStyles.zonaPro16Grey.copyWith(fontWeight: FontWeight.w600)),
      ),
    );
  }
}
