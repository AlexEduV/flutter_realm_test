import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:core_ui/core_ui.dart';
import 'package:test_flutter_project/common/enums/car_type.dart';
import 'package:test_flutter_project/common/enums/drawer_type.dart';
import 'package:test_flutter_project/common/extensions/context_extension.dart';
import 'package:test_flutter_project/presentation/bloc/search/search_page_cubit.dart';
import 'package:test_flutter_project/presentation/bloc/search/search_page_state.dart';
import 'package:test_flutter_project/presentation/bloc/user/user_data_cubit.dart';
import 'package:test_flutter_project/presentation/bloc/user/user_data_state.dart';
import 'package:test_flutter_project/presentation/pages/search/widgets/filters_drawer.dart';
import 'package:test_flutter_project/presentation/pages/search/widgets/model_filter_drawer.dart';
import 'package:test_flutter_project/presentation/pages/search/widgets/search_filter_button.dart';

import '../../../l10n/l10n_keys.dart';
import '../../widgets/announcement_item/announcement_list_item.dart';
import 'widgets/results_widget.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth >= 600; // You can adjust this threshold

    return BlocBuilder<SearchPageCubit, SearchPageState>(
      buildWhen: (previous, current) =>
          previous.drawerOpened != current.drawerOpened ||
          previous.selectedModels != current.selectedModels ||
          previous.currentSelectedType != current.currentSelectedType ||
          previous.allModels != current.allModels ||
          !listEquals(previous.selectedBodyTypes, current.selectedBodyTypes) ||
          !listEquals(previous.selectedColors, current.selectedColors) ||
          !listEquals(previous.selectedFuelTypes, current.selectedFuelTypes) ||
          !listEquals(previous.selectedTransmissionTypes, current.selectedTransmissionTypes) ||
          previous.selectedMinYear != current.selectedMinYear ||
          previous.selectedMaxYear != current.selectedMaxYear ||
          previous.selectedMinPrice != current.selectedMinPrice ||
          previous.selectedMaxPrice != current.selectedMaxPrice ||
          previous.allResults != current.allResults,
      builder: (context, state) {
        final cubit = context.read<SearchPageCubit>();
        final selectedFilterCount = cubit.getSelectedFilterCount();
        final filteredResults = cubit.getFilteredResults(state.allResults);
        final isDrawerOpened = state.drawerOpened != SearchDrawerType.empty;

        return Scaffold(
          backgroundColor: AppColors.scaffoldColor,
          appBar: AppBar(
            scrolledUnderElevation: isDrawerOpened ? 0.0 : null,
            centerTitle: true,
            title: Text(context.tr(L10nKeys.searchPageTitle), style: AppTextStyles.zonaPro20),
            backgroundColor: AppColors.scaffoldColor,
            //hidden hamburger icon this way;
            actions: const [SizedBox.shrink()],
          ),
          body: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(AppDimensions.normalL),
                  child: BlocBuilder<SearchPageCubit, SearchPageState>(
                    builder: (context, state) {
                      return SegmentedSwitch(
                        selectedIndex: state.currentSelectedType.index,
                        options: [
                          context.tr(L10nKeys.searchTabCars),
                          context.tr(L10nKeys.searchTabBikes),
                          context.tr(L10nKeys.searchTabTrucks),
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
              ),

              SliverToBoxAdapter(
                child: Builder(
                  builder: (context) {
                    final isFilterEmpty = state.selectedModels.isEmpty;
                    final modelFilters = isFilterEmpty
                        ? context.tr(L10nKeys.searchFilterModelPlaceholder)
                        : state.selectedModels.entries
                              .map((entry) => '${entry.key}: ${entry.value.join(', ')}')
                              .join('; ');

                    return SearchFilterButton(
                      icon: Icons.directions_car,
                      title: '${context.tr(L10nKeys.searchFilterModelTitle)}: ',
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
              ),

              SliverToBoxAdapter(
                child: Builder(
                  builder: (context) {
                    return SearchFilterButton(
                      icon: Icons.filter_list_sharp,
                      title: context.tr(L10nKeys.searchFilterParametersTitle),
                      selectionCount: selectedFilterCount.toString(),
                      onPressed: () {
                        context.read<SearchPageCubit>().openDrawer(SearchDrawerType.parameters);
                        Scaffold.of(context).openEndDrawer();
                      },
                    );
                  },
                ),
              ),

              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(AppDimensions.normalL),
                  child: ResultsWidget(resultsCount: filteredResults.length.toString()),
                ),
              ),

              if (filteredResults.isEmpty)
                SliverToBoxAdapter(
                  child: EmptyResultsPlaceholderWidget(
                    text: context.tr(L10nKeys.emptySearchPlaceholderText),
                  ),
                )
              else
                SliverPadding(
                  padding: const EdgeInsetsGeometry.only(bottom: AppDimensions.normalXL),
                  sliver: BlocBuilder<UserDataCubit, UserDataState>(
                    buildWhen: (previous, current) => previous.favoriteIds != current.favoriteIds,
                    builder: (context, userState) {
                      return SliverGrid(
                        delegate: SliverChildBuilderDelegate((context, index) {
                          return AnnouncementListItem(
                            isExploreItem: false,
                            car: filteredResults[index],
                            user: context.read<UserDataCubit>().user,
                            onDismissed: () {},
                          );
                        }, childCount: filteredResults.length),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: isTablet ? 2 : 1,
                          childAspectRatio: 16 / 14,
                        ),
                      );
                    },
                  ),
                ),
            ],
          ),
          endDrawer: state.drawerOpened == SearchDrawerType.model
              ? ModelFilterDrawer(models: state.allModels)
              : const FiltersDrawer(),
        );
      },
    );
  }
}
