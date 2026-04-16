import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_flutter_project/common/constants/app_colors.dart';
import 'package:test_flutter_project/common/constants/app_dimensions.dart';
import 'package:test_flutter_project/common/constants/app_semantics_labels.dart';
import 'package:test_flutter_project/common/constants/app_text_styles.dart';
import 'package:test_flutter_project/common/enums/body_type.dart';
import 'package:test_flutter_project/common/enums/fuel_type.dart';
import 'package:test_flutter_project/common/enums/transmission_type.dart';
import 'package:test_flutter_project/common/extensions/context_extension.dart';
import 'package:test_flutter_project/common/extensions/string_extension.dart';
import 'package:test_flutter_project/presentation/bloc/search/search_page_cubit.dart';
import 'package:test_flutter_project/presentation/bloc/search/search_page_state.dart';
import 'package:test_flutter_project/presentation/pages/search/widgets/debounced_text_form_field.dart';
import 'package:test_flutter_project/presentation/widgets/app_semantics.dart';

import '../../../../l10n/l10n_keys.dart';

class FiltersDrawer extends StatefulWidget {
  const FiltersDrawer({super.key});

  @override
  State<FiltersDrawer> createState() => _FiltersDrawerState();
}

class _FiltersDrawerState extends State<FiltersDrawer> {
  final minYearTextController = TextEditingController();
  final maxYearTextController = TextEditingController();

  final minPriceTextController = TextEditingController();
  final maxPriceTextController = TextEditingController();

  final checkBoxPosition = ListTileControlAffinity.leading;

  @override
  void initState() {
    super.initState();

    final state = context.read<SearchPageCubit>().state;

    minYearTextController.text = state.selectedMinYear ?? '';
    maxYearTextController.text = state.selectedMaxYear ?? '';
    minPriceTextController.text = state.selectedMinPrice ?? '';
    maxPriceTextController.text = state.selectedMaxPrice ?? '';
  }

  @override
  void dispose() {
    minYearTextController.dispose();
    maxYearTextController.dispose();
    minPriceTextController.dispose();
    maxPriceTextController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchPageCubit, SearchPageState>(
      builder: (context, state) {
        final cubit = context.read<SearchPageCubit>();

        final selectedBodyTypeSet = Set<String>.from(state.selectedBodyTypes);
        final selectedFuelTypeSet = Set<String>.from(state.selectedFuelTypes);
        final selectedTransmissionTypeSet = Set<String>.from(state.selectedTransmissionTypes);
        final selectedColorSet = Set<String>.from(state.selectedColors);

        final bodyTypeList = BodyType.filterByCarType(state.currentSelectedType);

        return Drawer(
          backgroundColor: AppColors.scaffoldColor,
          child: ListView(
            children: [
              DrawerHeader(
                child: Text(
                  context.tr(L10nKeys.searchFilterParametersTitle),
                  style: AppTextStyles.zonaPro20,
                ),
              ),

              if (state.allColors.isNotEmpty) ...[
                ListTile(
                  title: Text(
                    context.tr(L10nKeys.parameterColorName),
                    style: AppTextStyles.zonaPro18,
                  ),
                ),
              ],

              ...state.allColors.map((element) {
                final capitalisedElement = element.capitalizeFirst();

                return _buildCheckboxTile(
                  semanticsLabel: AppSemanticsLabels.filterDrawerColorCheckbox,
                  label: element.capitalizeFirst(),
                  isChecked: selectedColorSet.contains(capitalisedElement),
                  onChecked: () => cubit.addCarColorToSelection(capitalisedElement),
                  onUnChecked: () => cubit.removeCarColorFromSelection(capitalisedElement),
                );
              }),

              ListTile(
                title: Text(context.tr(L10nKeys.parameterYearName), style: AppTextStyles.zonaPro18),
              ),

              //todo: use a slider here
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(AppDimensions.normalS),
                      child: DebouncedTextFormField(
                        controller: minYearTextController,
                        label: '',
                        onDebouncedChanged: (value) => cubit.updateSelectedMinYear(value),
                        errorText: state.minYearError,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(AppDimensions.normalS),
                      child: DebouncedTextFormField(
                        controller: maxYearTextController,
                        label: '',
                        onDebouncedChanged: (value) => cubit.updateSelectedMaxYear(value),
                        errorText: state.maxYearError,
                      ),
                    ),
                  ),
                ],
              ),

              ListTile(
                title: Text(
                  context.tr(L10nKeys.parameterBodyTypeName),
                  style: AppTextStyles.zonaPro18,
                ),
              ),

              ...bodyTypeList.map(
                (element) => _buildCheckboxTile(
                  semanticsLabel: AppSemanticsLabels.filterDrawerBodyTypeCheckbox,
                  label: element.fromLocalisations(),
                  isChecked: selectedBodyTypeSet.contains(element.name),
                  onChecked: () => cubit.addBodyTypeToSelection(element.name),
                  onUnChecked: () => cubit.removeBodyTypeFromSelection(element.name),
                ),
              ),

              ListTile(
                title: Text(
                  context.tr(L10nKeys.parameterPriceRangeName),
                  style: AppTextStyles.zonaPro18,
                ),
              ),

              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(AppDimensions.normalS),
                      child: DebouncedTextFormField(
                        controller: minPriceTextController,
                        //todo: why the label is empty here?
                        label: '',
                        onDebouncedChanged: (newValue) => cubit.updateSelectedMinPrice(newValue),
                        errorText: state.minPriceError,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(AppDimensions.normalS),
                      child: DebouncedTextFormField(
                        controller: maxPriceTextController,
                        label: '',
                        onDebouncedChanged: (newValue) => cubit.updateSelectedMaxPrice(newValue),
                        errorText: state.maxPriceError,
                      ),
                    ),
                  ),
                ],
              ),

              ListTile(
                title: Text(
                  context.tr(L10nKeys.parameterFuelTypeName),
                  style: AppTextStyles.zonaPro18,
                ),
              ),

              ...FuelType.values.map(
                (element) => _buildCheckboxTile(
                  semanticsLabel: AppSemanticsLabels.filterDrawerFuelTypeCheckbox,
                  label: element.fromLocalisations(),
                  isChecked: selectedFuelTypeSet.contains(element.name),
                  onChecked: () => cubit.addFuelTypeToSelection(element.name),
                  onUnChecked: () => cubit.removeFuelTypeFromSelection(element.name),
                ),
              ),

              ListTile(
                title: Text(
                  context.tr(L10nKeys.parameterTransmissionTypeName),
                  style: AppTextStyles.zonaPro18,
                ),
              ),

              ...TransmissionType.values.map(
                (element) => _buildCheckboxTile(
                  semanticsLabel: AppSemanticsLabels.filterDrawerTransmissionTypeCheckbox,
                  label: element.fromLocalisations(),
                  isChecked: selectedTransmissionTypeSet.contains(element.name),
                  onChecked: () => cubit.addTransmissionTypeToSelection(element.name),
                  onUnChecked: () => cubit.removeTransmissionTypeFromSelection(element.name),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCheckboxTile({
    required String semanticsLabel,
    required String label,
    required bool? isChecked,
    required void Function() onChecked,
    required void Function() onUnChecked,
  }) {
    return AppSemantics(
      label: '$semanticsLabel $label',
      isChecked: isChecked,
      child: CheckboxListTile(
        title: Text(label),
        value: isChecked,
        onChanged: (bool? newValue) {
          if (newValue == true) {
            onChecked();
          } else {
            onUnChecked();
          }
        },
        controlAffinity: checkBoxPosition,
      ),
    );
  }
}
