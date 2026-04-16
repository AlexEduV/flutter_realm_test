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

              _buildCheckboxTile(
                semanticsLabel: AppSemanticsLabels.filterDrawerFuelTypeCheckbox,
                label: context.tr(L10nKeys.fuelTypeDiesel),
                isChecked: selectedFuelTypeSet.contains(FuelType.diesel.name),
                onChecked: () => cubit.addFuelTypeToSelection(FuelType.diesel.name),
                onUnChecked: () => cubit.removeFuelTypeFromSelection(FuelType.diesel.name),
              ),

              _buildCheckboxTile(
                semanticsLabel: AppSemanticsLabels.filterDrawerFuelTypeCheckbox,
                label: context.tr(L10nKeys.fuelTypeGasoline),
                isChecked: selectedFuelTypeSet.contains(FuelType.gasoline.name),
                onChecked: () => cubit.addFuelTypeToSelection(FuelType.gasoline.name),
                onUnChecked: () => cubit.removeFuelTypeFromSelection(FuelType.gasoline.name),
              ),

              _buildCheckboxTile(
                semanticsLabel: AppSemanticsLabels.filterDrawerFuelTypeCheckbox,
                label: context.tr(L10nKeys.fuelTypeEv),
                isChecked: selectedFuelTypeSet.contains(FuelType.ev.name),
                onChecked: () => cubit.addFuelTypeToSelection(FuelType.ev.name),
                onUnChecked: () => cubit.removeFuelTypeFromSelection(FuelType.ev.name),
              ),

              _buildCheckboxTile(
                semanticsLabel: AppSemanticsLabels.filterDrawerFuelTypeCheckbox,
                label: context.tr(L10nKeys.fuelTypeHybrid),
                isChecked: selectedFuelTypeSet.contains(FuelType.hybrid.name),
                onChecked: () => cubit.addFuelTypeToSelection(FuelType.hybrid.name),
                onUnChecked: () => cubit.removeFuelTypeFromSelection(FuelType.hybrid.name),
              ),

              ListTile(
                title: Text(
                  context.tr(L10nKeys.parameterTransmissionTypeName),
                  style: AppTextStyles.zonaPro18,
                ),
              ),

              _buildCheckboxTile(
                semanticsLabel: AppSemanticsLabels.filterDrawerTransmissionTypeCheckbox,
                label: context.tr(L10nKeys.transmissionTypeManual),
                isChecked: selectedTransmissionTypeSet.contains(TransmissionType.manual.name),
                onChecked: () => cubit.addTransmissionTypeToSelection(TransmissionType.manual.name),
                onUnChecked: () =>
                    cubit.removeTransmissionTypeFromSelection(TransmissionType.manual.name),
              ),

              _buildCheckboxTile(
                semanticsLabel: AppSemanticsLabels.filterDrawerTransmissionTypeCheckbox,
                label: context.tr(L10nKeys.transmissionTypeAutomatic),
                isChecked: selectedTransmissionTypeSet.contains(TransmissionType.automatic.name),
                onChecked: () =>
                    cubit.addTransmissionTypeToSelection(TransmissionType.automatic.name),
                onUnChecked: () =>
                    cubit.removeTransmissionTypeFromSelection(TransmissionType.automatic.name),
              ),

              _buildCheckboxTile(
                semanticsLabel: AppSemanticsLabels.filterDrawerTransmissionTypeCheckbox,
                label: context.tr(L10nKeys.transmissionTypeHybrid),
                isChecked: selectedTransmissionTypeSet.contains(TransmissionType.hybrid.name),
                onChecked: () => cubit.addTransmissionTypeToSelection(TransmissionType.hybrid.name),
                onUnChecked: () =>
                    cubit.removeTransmissionTypeFromSelection(TransmissionType.hybrid.name),
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
