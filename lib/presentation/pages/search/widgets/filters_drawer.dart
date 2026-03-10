import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_futter_project/common/app_colors.dart';
import 'package:test_futter_project/common/app_dimensions.dart';
import 'package:test_futter_project/common/app_semantics_labels.dart';
import 'package:test_futter_project/common/app_text_styles.dart';
import 'package:test_futter_project/common/enums/body_type.dart';
import 'package:test_futter_project/common/enums/car_type.dart';
import 'package:test_futter_project/common/enums/fuel_type.dart';
import 'package:test_futter_project/common/enums/transmission_type.dart';
import 'package:test_futter_project/common/extensions/context_extension.dart';
import 'package:test_futter_project/common/extensions/string_extension.dart';
import 'package:test_futter_project/presentation/bloc/search/search_page_cubit.dart';
import 'package:test_futter_project/presentation/bloc/search/search_page_state.dart';
import 'package:test_futter_project/presentation/pages/search/widgets/debounced_text_form_field.dart';
import 'package:test_futter_project/presentation/widgets/app_semantics.dart';

import '../../../../utils/l10n_keys.dart';

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

              ListTile(
                title: Text(
                  context.tr(L10nKeys.parameterColorName),
                  style: AppTextStyles.zonaPro18,
                ),
              ),

              ...state.allColors.map((element) {
                final capitalisedElement = element.capitalizeFirst();

                return _buildCheckboxTile(
                  semanticsLabel: '',
                  label: element.capitalizeFirst(),
                  isChecked: selectedColorSet.contains(capitalisedElement),
                  onChecked: () => cubit.addCarColorToSelection(capitalisedElement),
                  onUnChecked: () => cubit.removeCarColorFromSelection(capitalisedElement),
                );
              }),

              ListTile(
                title: Text(context.tr(L10nKeys.parameterYearName), style: AppTextStyles.zonaPro18),
              ),

              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(AppDimensions.normalS),
                      child: DebouncedTextFormField(
                        controller: minYearTextController,
                        label: state.minYearFieldParamsModel?.label ?? '',
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
                        label: state.maxYearFieldParamsModel?.label ?? '',
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

              if (state.currentSelectedType == CarType.car) ...[
                _buildCheckboxTile(
                  semanticsLabel: AppSemanticsLabels.filterDrawerBodyTypeCheckbox,
                  label: context.tr(L10nKeys.bodyTypeSedan),
                  isChecked: selectedBodyTypeSet.contains(BodyType.sedan.name),
                  onChecked: () => cubit.addBodyTypeToSelection(BodyType.sedan.name),
                  onUnChecked: () => cubit.removeBodyTypeFromSelection(BodyType.sedan.name),
                ),

                _buildCheckboxTile(
                  semanticsLabel: AppSemanticsLabels.filterDrawerBodyTypeCheckbox,
                  label: context.tr(L10nKeys.bodyTypeHatchback),
                  isChecked: selectedBodyTypeSet.contains(BodyType.hatchback.name),
                  onChecked: () => cubit.addBodyTypeToSelection(BodyType.hatchback.name),
                  onUnChecked: () => cubit.removeBodyTypeFromSelection(BodyType.hatchback.name),
                ),

                _buildCheckboxTile(
                  semanticsLabel: AppSemanticsLabels.filterDrawerBodyTypeCheckbox,
                  label: context.tr(L10nKeys.bodyTypeUniversal),
                  isChecked: selectedBodyTypeSet.contains(BodyType.universal.name),
                  onChecked: () => cubit.addBodyTypeToSelection(BodyType.universal.name),
                  onUnChecked: () => cubit.removeBodyTypeFromSelection(BodyType.universal.name),
                ),

                _buildCheckboxTile(
                  semanticsLabel: AppSemanticsLabels.filterDrawerBodyTypeCheckbox,
                  label: context.tr(L10nKeys.bodyTypeMinivan),
                  isChecked: selectedBodyTypeSet.contains(BodyType.minivan.name),
                  onChecked: () => cubit.addBodyTypeToSelection(BodyType.minivan.name),
                  onUnChecked: () => cubit.removeBodyTypeFromSelection(BodyType.minivan.name),
                ),

                _buildCheckboxTile(
                  semanticsLabel: AppSemanticsLabels.filterDrawerBodyTypeCheckbox,
                  label: context.tr(L10nKeys.bodyTypeCoupe),
                  isChecked: selectedBodyTypeSet.contains(BodyType.coupe.name),
                  onChecked: () => cubit.addBodyTypeToSelection(BodyType.coupe.name),
                  onUnChecked: () => cubit.removeBodyTypeFromSelection(BodyType.coupe.name),
                ),

                _buildCheckboxTile(
                  semanticsLabel: AppSemanticsLabels.filterDrawerBodyTypeCheckbox,
                  label: context.tr(L10nKeys.bodyTypeCrossover),
                  isChecked: selectedBodyTypeSet.contains(BodyType.crossover.name),
                  onChecked: () => cubit.addBodyTypeToSelection(BodyType.crossover.name),
                  onUnChecked: () => cubit.removeBodyTypeFromSelection(BodyType.crossover.name),
                ),
              ] else if (state.currentSelectedType == CarType.truck) ...[
                _buildCheckboxTile(
                  semanticsLabel: AppSemanticsLabels.filterDrawerBodyTypeCheckbox,
                  label: context.tr(L10nKeys.bodyTypeSemi),
                  isChecked: selectedBodyTypeSet.contains(BodyType.semi.name),
                  onChecked: () => cubit.addBodyTypeToSelection(BodyType.semi.name),
                  onUnChecked: () => cubit.removeBodyTypeFromSelection(BodyType.semi.name),
                ),
              ] else ...[
                _buildCheckboxTile(
                  semanticsLabel: AppSemanticsLabels.filterDrawerBodyTypeCheckbox,
                  label: context.tr(L10nKeys.bodyTypeBike),
                  isChecked: selectedBodyTypeSet.contains(BodyType.bike.name),
                  onChecked: () => cubit.addBodyTypeToSelection(BodyType.bike.name),
                  onUnChecked: () => cubit.removeBodyTypeFromSelection(BodyType.bike.name),
                ),
              ],

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
                        label: state.minPriceFieldParamsModel?.label ?? '',
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
                        label: state.maxPriceFieldParamsModel?.label ?? '',
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
