import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:test_futter_project/common/app_colors.dart';
import 'package:test_futter_project/common/app_dimensions.dart';
import 'package:test_futter_project/common/app_semantics_labels.dart';
import 'package:test_futter_project/common/app_text_styles.dart';
import 'package:test_futter_project/common/enums/car_type.dart';
import 'package:test_futter_project/common/enums/drawer_type.dart';
import 'package:test_futter_project/presentation/bloc/search/search_page_cubit.dart';
import 'package:test_futter_project/presentation/bloc/search/search_page_state.dart';
import 'package:test_futter_project/presentation/bloc/user/user_data_cubit.dart';
import 'package:test_futter_project/presentation/pages/search/widgets/empty_search_placeholder_widget.dart';
import 'package:test_futter_project/presentation/pages/search/widgets/model_filter_drawer.dart';
import 'package:test_futter_project/presentation/pages/search/widgets/parameter_filter_drawer.dart';
import 'package:test_futter_project/presentation/pages/search/widgets/search_filter_button.dart';
import 'package:test_futter_project/presentation/widgets/app_semantics.dart';
import 'package:test_futter_project/presentation/widgets/segmented_switch.dart';
import 'package:test_futter_project/utils/l10n.dart';

import '../home/explore_page/widgets/explore_list_item.dart';
import '../home/explore_page/widgets/results_widget.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchPageCubit, SearchPageState>(
      buildWhen: (previous, current) =>
          previous.drawerOpened != current.drawerOpened ||
          !listEquals(previous.selectedModels, current.selectedModels) ||
          previous.currentSelectedType != current.currentSelectedType ||
          previous.allModels != current.allModels ||
          !listEquals(previous.selectedBodyTypes, current.selectedBodyTypes) ||
          !listEquals(previous.selectedTransmissionTypes, current.selectedTransmissionTypes),
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.scaffoldColor,
          appBar: AppBar(
            centerTitle: true,
            title: Text(AppLocalisations.searchPageTitle, style: AppTextStyles.zonaPro20),
            leading: AppSemantics(
              label: AppSemanticsLabels.backButton,
              button: true,
              child: IconButton(
                onPressed: () => context.pop(),
                icon: const Icon(
                  Icons.arrow_back,
                  size: AppDimensions.appBarIconSize,
                  color: AppColors.headerColor,
                ),
              ),
            ),
            backgroundColor: AppColors.scaffoldColor,
            //hidden hamburger icon this way;
            actions: [const SizedBox.shrink()],
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
              ),

              SliverToBoxAdapter(
                child: Builder(
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
              ),

              SliverToBoxAdapter(
                child: Builder(
                  builder: (context) {
                    return SearchFilterButton(
                      icon: Icons.settings_input_component,
                      title: AppLocalisations.searchFilterParametersTitle,
                      //todo: update the real count
                      selectionCount: '2',
                      onPressed: () {
                        context.read<SearchPageCubit>().openDrawer(SearchDrawerType.parameters);
                        Scaffold.of(context).openEndDrawer();
                      },
                    );
                  },
                ),
              ),

              SliverToBoxAdapter(
                child: BlocBuilder<SearchPageCubit, SearchPageState>(
                  builder: (context, state) {
                    return Padding(
                      padding: const EdgeInsets.all(AppDimensions.normalL),
                      child: ResultsWidget(results: state.results.length.toString()),
                    );
                  },
                ),
              ),

              BlocBuilder<SearchPageCubit, SearchPageState>(
                builder: (context, state) {
                  if (state.results.isEmpty) {
                    return const SliverToBoxAdapter(child: EmptySearchPlaceholderWidget());
                  }

                  return SliverPadding(
                    padding: const EdgeInsetsGeometry.only(bottom: AppDimensions.normalXL),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        return ExploreListItem(
                          car: state.results[index],
                          user: context.read<UserDataCubit>().user,
                          onDismissed: () {},
                        );
                      }, childCount: state.results.length),
                    ),
                  );
                },
              ),
            ],
          ),
          endDrawer: state.drawerOpened == SearchDrawerType.model
              ? ModelFilterDrawer(models: state.allModels)
              : const ParameterFilterDrawer(),
        );
      },
    );
  }
}
