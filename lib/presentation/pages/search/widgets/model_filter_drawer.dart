import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_futter_project/common/app_text_styles.dart';
import 'package:test_futter_project/presentation/bloc/search/search_page_cubit.dart';
import 'package:test_futter_project/presentation/bloc/search/search_page_state.dart';
import 'package:test_futter_project/utils/l10n.dart';

class ModelFilterDrawer extends StatelessWidget {
  final List<String> models;

  const ModelFilterDrawer({required this.models, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchPageCubit, SearchPageState>(
      builder: (context, state) {
        final selectedSet = Set<String>.from(state.selectedModels);
        final allSet = Set<String>.from(models);
        final areAllSelected =
            selectedSet.length == allSet.length && selectedSet.containsAll(allSet);

        return Drawer(
          child: ListView(
            children: [
              const DrawerHeader(
                child: Text(
                  AppLocalisations.searchFilterModelTitle,
                  style: AppTextStyles.zonaPro20,
                ),
              ),

              CheckboxListTile(
                value: areAllSelected,
                onChanged: (bool? value) {
                  if (value ?? false) {
                    context.read<SearchPageCubit>().updateModelSelection(models);
                  } else {
                    context.read<SearchPageCubit>().updateModelSelection([]);
                  }
                },
                title: const Text(AppLocalisations.searchFilterModelPlaceholder),
                controlAffinity: ListTileControlAffinity.leading,
              ),

              ...models.map((model) {
                final isSelected = selectedSet.contains(model);
                return CheckboxListTile(
                  value: isSelected,
                  onChanged: (bool? newValue) {
                    if (newValue == true) {
                      context.read<SearchPageCubit>().addCarModelToSelection(model);
                    } else {
                      context.read<SearchPageCubit>().removeCarModelFromSelection(model);
                    }
                  },
                  title: Text(model),
                  controlAffinity: ListTileControlAffinity.leading,
                );
              }),
            ],
          ),
        );
      },
    );
  }

  bool areTwoListsEqual(List listA, List listB) {
    return Set<String>.from(listA).containsAll(listB) && Set<String>.from(listB).containsAll(listA);
  }
}
