import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:test_flutter_project/common/extensions/context_extension.dart';

import '../../../../inbox/inbox_page_identifiers.dart';

class GifLabel extends StatelessWidget {
  const GifLabel({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppDimensions.minorM),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppDimensions.normalS),
      ),
      child: Text(
        context.tr(InboxPageLocaleKeys.gifMessagePlaceholder),
        style: AppTextStyles.zonaPro14.copyWith(fontWeight: FontWeight.w600),
      ),
    );
  }
}
