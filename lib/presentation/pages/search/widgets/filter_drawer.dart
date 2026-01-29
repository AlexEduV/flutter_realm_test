import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_futter_project/common/app_text_styles.dart';
import 'package:test_futter_project/presentation/bloc/search/search_page_cubit.dart';
import 'package:test_futter_project/presentation/bloc/search/search_page_state.dart';
import 'package:test_futter_project/utils/l10n.dart';

class FilterDrawer extends StatelessWidget {
  final List<String> models;

  const FilterDrawer({required this.models, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchPageCubit, SearchPageState>(
      builder: (context, state) {
        return Drawer(
          child: ListView.builder(
            itemCount: 2 + models.length,
            itemBuilder: (context, index) {
              if (index == 0) {
                return DrawerHeader(
                  child: Text(
                    AppLocalisations.searchFilterModelTitle,
                    style: AppTextStyles.zonaPro20,
                  ),
                );
              } else if (index == 1) {
                return ListTile(
                  leading: Checkbox(
                    value: areTwoListsEqual(state.selectedModels, models),
                    onChanged: (bool? value) {
                      if (value ?? false) {
                        context.read<SearchPageCubit>().updateModelSelection(models);
                      } else {
                        context.read<SearchPageCubit>().updateModelSelection([]);
                      }
                    },
                  ),
                  title: Text(AppLocalisations.searchFilterModelPlaceholder),
                );
              } else {
                final model = models[index - 2];

                return ListTile(
                  leading: Checkbox(
                    value: state.selectedModels.contains(model) || state.selectedModels == models,
                    onChanged: (bool? newValue) {
                      if (newValue ?? false) {
                        context.read<SearchPageCubit>().addCarModelToSelection(model);
                      } else {
                        context.read<SearchPageCubit>().removeCarModelFromSelection(model);
                      }
                    },
                  ),
                  title: Text(model),
                );
              }
            },
          ),
        );
      },
    );
  }

  bool areTwoListsEqual(List listA, List listB) {
    return Set<String>.from(listA).containsAll(listB) && Set<String>.from(listB).containsAll(listA);
  }
}
