import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:test_futter_project/common/app_colors.dart';
import 'package:test_futter_project/common/app_dimensions.dart';
import 'package:test_futter_project/common/app_routes.dart';
import 'package:test_futter_project/common/app_text_styles.dart';
import 'package:test_futter_project/utils/l10n.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(AppLocalisations.searchPageTitle, style: AppTextStyles.zonaPro24),
        leading: IconButton(
          onPressed: () => context.go(AppRoutes.home),
          icon: Icon(
            Icons.arrow_back,
            size: AppDimensions.appBarIconSize,
            color: AppColors.headerColor,
          ),
        ),
      ),
      body: Column(children: []),
    );
  }
}
