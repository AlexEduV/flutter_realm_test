import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:test_futter_project/common/app_colors.dart';
import 'package:test_futter_project/common/app_dimensions.dart';
import 'package:test_futter_project/common/app_text_styles.dart';
import 'package:test_futter_project/presentation/pages/home/widgets/results_widget.dart';
import 'package:test_futter_project/presentation/pages/search/widgets/search_filter.dart';
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

          SearchFilter(
            icon: Icons.local_shipping_outlined,
            text: '${AppLocalisations.searchFilterModelTitle}: BMW',
            selectionCount: '1',
          ),

          SearchFilter(
            icon: Icons.settings_input_component,
            text: AppLocalisations.searchFilterParametersTitle,
            selectionCount: '2',
          ),

          Padding(
            padding: const EdgeInsets.all(AppDimensions.normalL),
            child: ResultsWidget(results: '12'),
          ),

          //todo: not indexed stack, just a list of search results;
          //the fetch request should be once, but the results should be cached.
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
