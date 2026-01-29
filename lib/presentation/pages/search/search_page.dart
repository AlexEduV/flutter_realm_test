import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:test_futter_project/common/app_colors.dart';
import 'package:test_futter_project/common/app_dimensions.dart';
import 'package:test_futter_project/common/app_text_styles.dart';
import 'package:test_futter_project/presentation/widgets/segmented_switch.dart';
import 'package:test_futter_project/utils/l10n.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text(AppLocalisations.searchPageTitle, style: AppTextStyles.zonaPro20),
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: Icon(
            Icons.arrow_back,
            size: AppDimensions.appBarIconSize,
            color: AppColors.headerColor,
          ),
        ),
        backgroundColor: AppColors.scaffoldColor,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(AppDimensions.normalL),
            child: SegmentedSwitch(
              selectedIndex: _selectedIndex,
              options: [
                AppLocalisations.searchTabCars,
                AppLocalisations.searchTabBikes,
                AppLocalisations.searchTabTrucks,
              ],
              onChanged: (newIndex) {
                setState(() {
                  _selectedIndex = newIndex;
                });
              },
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.normalL,
              vertical: AppDimensions.contentPadding,
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(AppDimensions.normalL),
              ),
              padding: EdgeInsets.all(AppDimensions.normalS),
              child: Row(
                spacing: AppDimensions.normalXS,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppDimensions.normalXS),
                      color: AppColors.placeholderColor,
                    ),
                    height: 40,
                    width: 40,
                  ),

                  Text('Model: BMW', style: AppTextStyles.zonaPro18),
                ],
              ),
            ),
          ),

          Expanded(
            child: IndexedStack(
              index: _selectedIndex,
              children: [
                Center(child: Text('Page 1')),
                Center(child: Text('Page 2')),
                Center(child: Text('Page 3')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
