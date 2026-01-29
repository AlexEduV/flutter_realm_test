import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:test_futter_project/common/app_colors.dart';
import 'package:test_futter_project/common/app_dimensions.dart';
import 'package:test_futter_project/common/app_text_styles.dart';
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
        title: Text(AppLocalisations.searchPageTitle, style: AppTextStyles.zonaPro24),
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
          ToggleButtons(
            isSelected: List.generate(3, (index) => index == _selectedIndex),
            onPressed: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            children: [
              Padding(padding: EdgeInsets.symmetric(horizontal: 16), child: Text('Cars')),
              Padding(padding: EdgeInsets.symmetric(horizontal: 16), child: Text('Bikes')),
              Padding(padding: EdgeInsets.symmetric(horizontal: 16), child: Text('Trucks')),
            ],
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
