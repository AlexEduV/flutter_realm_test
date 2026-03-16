import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_futter_project/common/app_dimensions.dart';
import 'package:test_futter_project/common/app_text_styles.dart';
import 'package:test_futter_project/common/extensions/context_extension.dart';
import 'package:test_futter_project/presentation/bloc/search/search_page_cubit.dart';
import 'package:test_futter_project/presentation/bloc/search/search_page_state.dart';

import '../../../../l10n/l10n_keys.dart';

class ModelFilterDrawer extends StatelessWidget {
  final Map<String, List<String>> models;

  const ModelFilterDrawer({required this.models, super.key});

  @override
  Widget build(BuildContext context) {
    final checkBoxPosition = ListTileControlAffinity.leading;

    return BlocBuilder<SearchPageCubit, SearchPageState>(
      builder: (context, state) {
        final selectedSet = state.selectedModels;
        final allSet = models;

        final equality = const DeepCollectionEquality.unordered().equals;
        final unorderedListEquality = const UnorderedIterableEquality();
        final areAllSelected = equality(selectedSet, allSet);

        return Drawer(
          child: ListView(
            children: [
              DrawerHeader(
                child: Text(
                  context.tr(L10nKeys.searchFilterModelTitle),
                  style: AppTextStyles.zonaPro20,
                ),
              ),

              CheckboxListTile(
                value: areAllSelected,
                onChanged: (bool? value) {
                  if (value ?? false) {
                    context.read<SearchPageCubit>().updateModelSelection(models);
                  } else {
                    context.read<SearchPageCubit>().updateModelSelection({});
                  }
                },
                title: Text(
                  context.tr(L10nKeys.searchFilterModelPlaceholder),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                controlAffinity: checkBoxPosition,
              ),

              ...allSet.entries.map((entry) {
                final manufacturer = entry.key;
                final models = entry.value;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: AppDimensions.minorL),
                      child: CheckboxListTile(
                        value: unorderedListEquality.equals(
                          state.selectedModels[manufacturer],
                          state.allModels[manufacturer],
                        ),
                        onChanged: (bool? newValue) {
                          if (newValue == true) {
                            context.read<SearchPageCubit>().addManufacturerToSelection(
                              manufacturer,
                            );
                          } else {
                            context.read<SearchPageCubit>().removeManufacturerFromSelection(
                              manufacturer,
                            );
                          }
                        },
                        title: Text(
                          manufacturer,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        controlAffinity: checkBoxPosition,
                      ),
                    ),
                    ...models.map((model) {
                      final isSelected = selectedSet[manufacturer]?.contains(model) ?? false;
                      return CheckboxListTile(
                        value: isSelected,
                        onChanged: (bool? newValue) {
                          if (newValue == true) {
                            context.read<SearchPageCubit>().addCarModelToSelection(
                              manufacturer,
                              model,
                            );
                          } else {
                            context.read<SearchPageCubit>().removeCarModelFromSelection(
                              manufacturer,
                              model,
                            );
                          }
                        },
                        title: Text(model),
                        controlAffinity: checkBoxPosition,
                      );
                    }),
                  ],
                );
              }),
            ],
          ),
        );
      },
    );
  }
}
