import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:test_futter_project/common/app_colors.dart';
import 'package:test_futter_project/common/app_dimensions.dart';
import 'package:test_futter_project/common/app_text_styles.dart';
import 'package:test_futter_project/common/enums/car_type.dart';
import 'package:test_futter_project/common/enums/drawer_type.dart';
import 'package:test_futter_project/presentation/bloc/search/search_page_cubit.dart';
import 'package:test_futter_project/presentation/bloc/search/search_page_state.dart';
import 'package:test_futter_project/presentation/pages/home/widgets/explore_list_item.dart';
import 'package:test_futter_project/presentation/pages/home/widgets/results_widget.dart';
import 'package:test_futter_project/presentation/pages/search/widgets/filter_drawer.dart';
import 'package:test_futter_project/presentation/pages/search/widgets/search_filter_button.dart';
import 'package:test_futter_project/presentation/widgets/segmented_switch.dart';
import 'package:test_futter_project/utils/l10n.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchPageCubit, SearchPageState>(
      buildWhen: (previous, current) => previous.drawerOpened != current.drawerOpened,
      builder: (context, state) {
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
                child: BlocBuilder<SearchPageCubit, SearchPageState>(
                  builder: (context, state) {
                    return SegmentedSwitch(
                      selectedIndex: state.currentSelectedType.index,
                      options: [
                        AppLocalisations.searchTabCars,
                        AppLocalisations.searchTabBikes,
                        AppLocalisations.searchTabTrucks,
                      ],
                      onChanged: (newIndex) {
                        context.read<SearchPageCubit>().updateTypeSelection(
                          CarType.values[newIndex],
                        );
                        context.read<SearchPageCubit>().loadData();
                      },
                    );
                  },
                ),
              ),

              Builder(
                builder: (context) {
                  final isFilterEmpty = state.selectedModels.isEmpty;
                  final modelFilters = isFilterEmpty
                      ? AppLocalisations.searchFilterModelPlaceholder
                      : state.selectedModels.join(', ');

                  return SearchFilterButton(
                    icon: Icons.local_shipping_outlined,
                    title: '${AppLocalisations.searchFilterModelTitle}: ',
                    text: modelFilters,
                    selectionCount: state.selectedModels.length.toString(),
                    onPressed: () {
                      context.read<SearchPageCubit>().openDrawer(SearchDrawerType.model);
                      Scaffold.of(context).openEndDrawer();
                    },
                    isPlaceHolder: isFilterEmpty,
                  );
                },
              ),

              SearchFilterButton(
                icon: Icons.settings_input_component,
                title: AppLocalisations.searchFilterParametersTitle,
                selectionCount: '2',
              ),

              BlocBuilder<SearchPageCubit, SearchPageState>(
                builder: (context, state) {
                  return Padding(
                    padding: const EdgeInsets.all(AppDimensions.normalL),
                    child: ResultsWidget(results: state.results.length.toString()),
                  );
                },
              ),

              BlocBuilder<SearchPageCubit, SearchPageState>(
                builder: (context, state) {
                  return Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return ExploreListItem(car: state.results[index], onDismissed: () {});
                      },
                      itemCount: state.results.length,
                    ),
                  );
                },
              ),
            ],
          ),
          endDrawer: FilterDrawer(
            models: context.read<SearchPageCubit>().getModelsFromEntities(state.results),
          ),
        );
      },
    );
  }
}
