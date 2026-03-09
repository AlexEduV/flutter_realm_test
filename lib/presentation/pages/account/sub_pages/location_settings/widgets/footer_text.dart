import 'package:flutter/material.dart';
import 'package:test_futter_project/common/app_semantics_labels.dart';

import '../../../../../widgets/app_semantics.dart';

class FooterText extends StatelessWidget {
  final String text;

  const FooterText({required this.text, super.key});

  @override
  Widget build(BuildContext context) {
    return AppSemantics(
      label: AppSemanticsLabels.privacyLinkItem,
      child: InkWell(onTap: () {}, child: Text(text)),
    );
  }
}
