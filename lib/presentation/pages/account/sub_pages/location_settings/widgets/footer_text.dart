import 'package:flutter/material.dart';
import 'package:test_futter_project/common/app_semantics_labels.dart';
import 'package:url_launcher/url_launcher.dart';

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
            ? () async {
                final link = Uri.parse(url ?? '');
                try {
                  await launchUrl(link);
                } catch (e) {
                  debugPrint('Could not launch $url: $e');
                }
              }
            : null,
        child: Text(text, style: AppTextStyles.zonaPro16Grey.copyWith(fontWeight: FontWeight.w600)),
      ),
    );
  }
}
