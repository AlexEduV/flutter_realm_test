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
import 'package:test_futter_project/presentation/bloc/search/search_page_cubit.dart';
import 'package:test_futter_project/presentation/bloc/search/search_page_state.dart';
import 'package:test_futter_project/presentation/pages/search/widgets/debounced_text_form_field.dart';
import 'package:test_futter_project/presentation/widgets/app_semantics.dart';
import 'package:test_futter_project/utils/l10n.dart';

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
        final selectedBodyTypeSet = Set<String>.from(state.selectedBodyTypes);
        final selectedFuelTypeSet = Set<String>.from(state.selectedFuelTypes);
        final selectedTransmissionTypeSet = Set<String>.from(state.selectedTransmissionTypes);

        final isSedanBodyTypeChecked = selectedBodyTypeSet.contains(BodyType.sedan.name);
        final isHatchbackBodyTypeChecked = selectedBodyTypeSet.contains(BodyType.hatchback.name);
        final isUniversalBodyTypeChecked = selectedBodyTypeSet.contains(BodyType.universal.name);
        final isMinivanBodyTypeChecked = selectedBodyTypeSet.contains(BodyType.minivan.name);
        final isCoupeBodyTypeChecked = selectedBodyTypeSet.contains(BodyType.coupe.name);
        final isCrossoverBodyTypeChecked = selectedBodyTypeSet.contains(BodyType.crossover.name);
        final isSemiBodyTypeChecked = selectedBodyTypeSet.contains(BodyType.semi.name);
        final isBikeBodyTypeChecked = selectedBodyTypeSet.contains(BodyType.bike.name);

        final isDieselFuelTypeChecked = selectedFuelTypeSet.contains(FuelType.diesel.name);
        final isGasolineFuelTypeChecked = selectedFuelTypeSet.contains(FuelType.gasoline.name);
        final isEvFuelTypeChecked = selectedFuelTypeSet.contains(FuelType.ev.name);
        final isHybridFuelTypeChecked = selectedFuelTypeSet.contains(FuelType.hybrid.name);

        final isManualTransmissionTypeChecked = selectedTransmissionTypeSet.contains(
          TransmissionType.manual.name,
        );
        final isAutomaticTransmissionTypeChecked = selectedTransmissionTypeSet.contains(
          TransmissionType.automatic.name,
        );
        final isHybridTransmissionTypeChecked = selectedTransmissionTypeSet.contains(
          TransmissionType.hybrid.name,
        );

        final cubit = context.read<SearchPageCubit>();

        return Drawer(
          backgroundColor: AppColors.scaffoldColor,
          child: ListView(
            children: [
              DrawerHeader(
                child: Text(
                  AppLocalisations.searchFilterParametersTitle,
                  style: AppTextStyles.zonaPro20,
                ),
              ),

              ListTile(
                title: Text(AppLocalisations.parameterYearName, style: AppTextStyles.zonaPro18),
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
                title: Text(AppLocalisations.parameterBodyTypeName, style: AppTextStyles.zonaPro18),
              ),

              if (state.currentSelectedType == CarType.car) ...[
                _buildCheckboxTile(
                  semanticsLabel: AppSemanticsLabels.filterDrawerBodyTypeCheckbox,
                  label: AppLocalisations.bodyTypeSedan,
                  isChecked: isSedanBodyTypeChecked,
                  onChecked: () => cubit.addBodyTypeToSelection(BodyType.sedan.name),
                  onUnChecked: () => cubit.removeBodyTypeFromSelection(BodyType.sedan.name),
                ),

                _buildCheckboxTile(
                  semanticsLabel: AppSemanticsLabels.filterDrawerBodyTypeCheckbox,
                  label: AppLocalisations.bodyTypeHatchback,
                  isChecked: isHatchbackBodyTypeChecked,
                  onChecked: () => cubit.addBodyTypeToSelection(BodyType.hatchback.name),
                  onUnChecked: () => cubit.removeBodyTypeFromSelection(BodyType.hatchback.name),
                ),

                _buildCheckboxTile(
                  semanticsLabel: AppSemanticsLabels.filterDrawerBodyTypeCheckbox,
                  label: AppLocalisations.bodyTypeUniversal,
                  isChecked: isUniversalBodyTypeChecked,
                  onChecked: () => cubit.addBodyTypeToSelection(BodyType.universal.name),
                  onUnChecked: () => cubit.removeBodyTypeFromSelection(BodyType.universal.name),
                ),

                _buildCheckboxTile(
                  semanticsLabel: AppSemanticsLabels.filterDrawerBodyTypeCheckbox,
                  label: AppLocalisations.bodyTypeMinivan,
                  isChecked: isMinivanBodyTypeChecked,
                  onChecked: () => cubit.addBodyTypeToSelection(BodyType.minivan.name),
                  onUnChecked: () => cubit.removeBodyTypeFromSelection(BodyType.minivan.name),
                ),

                _buildCheckboxTile(
                  semanticsLabel: AppSemanticsLabels.filterDrawerBodyTypeCheckbox,
                  label: AppLocalisations.bodyTypeCoupe,
                  isChecked: isCoupeBodyTypeChecked,
                  onChecked: () => cubit.addBodyTypeToSelection(BodyType.coupe.name),
                  onUnChecked: () => cubit.removeBodyTypeFromSelection(BodyType.coupe.name),
                ),

                _buildCheckboxTile(
                  semanticsLabel: AppSemanticsLabels.filterDrawerBodyTypeCheckbox,
                  label: AppLocalisations.bodyTypeCrossover,
                  isChecked: isCrossoverBodyTypeChecked,
                  onChecked: () => cubit.addBodyTypeToSelection(BodyType.crossover.name),
                  onUnChecked: () => cubit.removeBodyTypeFromSelection(BodyType.crossover.name),
                ),
              ] else if (state.currentSelectedType == CarType.truck) ...[
                _buildCheckboxTile(
                  semanticsLabel: AppSemanticsLabels.filterDrawerBodyTypeCheckbox,
                  label: AppLocalisations.bodyTypeSemi,
                  isChecked: isSemiBodyTypeChecked,
                  onChecked: () => cubit.addBodyTypeToSelection(BodyType.semi.name),
                  onUnChecked: () => cubit.removeBodyTypeFromSelection(BodyType.semi.name),
                ),
              ] else ...[
                _buildCheckboxTile(
                  semanticsLabel: AppSemanticsLabels.filterDrawerBodyTypeCheckbox,
                  label: AppLocalisations.bodyTypeBike,
                  isChecked: isBikeBodyTypeChecked,
                  onChecked: () => cubit.addBodyTypeToSelection(BodyType.bike.name),
                  onUnChecked: () => cubit.removeBodyTypeFromSelection(BodyType.bike.name),
                ),
              ],

              ListTile(
                title: Text(
                  AppLocalisations.parameterPriceRangeName,
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
                title: Text(AppLocalisations.parameterFuelTypeName, style: AppTextStyles.zonaPro18),
              ),

              _buildCheckboxTile(
                semanticsLabel: AppSemanticsLabels.filterDrawerFuelTypeCheckbox,
                label: AppLocalisations.fuelTypeDiesel,
                isChecked: isDieselFuelTypeChecked,
                onChecked: () => cubit.addFuelTypeToSelection(FuelType.diesel.name),
                onUnChecked: () => cubit.removeFuelTypeFromSelection(FuelType.diesel.name),
              ),

              _buildCheckboxTile(
                semanticsLabel: AppSemanticsLabels.filterDrawerFuelTypeCheckbox,
                label: AppLocalisations.fuelTypeGasoline,
                isChecked: isGasolineFuelTypeChecked,
                onChecked: () => cubit.addFuelTypeToSelection(FuelType.gasoline.name),
                onUnChecked: () => cubit.removeFuelTypeFromSelection(FuelType.gasoline.name),
              ),

              _buildCheckboxTile(
                semanticsLabel: AppSemanticsLabels.filterDrawerFuelTypeCheckbox,
                label: AppLocalisations.fuelTypeEv,
                isChecked: isEvFuelTypeChecked,
                onChecked: () => cubit.addFuelTypeToSelection(FuelType.ev.name),
                onUnChecked: () => cubit.removeFuelTypeFromSelection(FuelType.ev.name),
              ),

              _buildCheckboxTile(
                semanticsLabel: AppSemanticsLabels.filterDrawerFuelTypeCheckbox,
                label: AppLocalisations.fuelTypeHybrid,
                isChecked: isHybridFuelTypeChecked,
                onChecked: () => cubit.addFuelTypeToSelection(FuelType.hybrid.name),
                onUnChecked: () => cubit.removeFuelTypeFromSelection(FuelType.hybrid.name),
              ),

              ListTile(
                title: Text(
                  AppLocalisations.parameterTransmissionTypeName,
                  style: AppTextStyles.zonaPro18,
                ),
              ),

              _buildCheckboxTile(
                semanticsLabel: AppSemanticsLabels.filterDrawerTransmissionTypeCheckbox,
                label: AppLocalisations.transmissionTypeManual,
                isChecked: isManualTransmissionTypeChecked,
                onChecked: () => cubit.addTransmissionTypeToSelection(TransmissionType.manual.name),
                onUnChecked: () =>
                    cubit.removeTransmissionTypeFromSelection(TransmissionType.manual.name),
              ),

              _buildCheckboxTile(
                semanticsLabel: AppSemanticsLabels.filterDrawerTransmissionTypeCheckbox,
                label: AppLocalisations.transmissionTypeAutomatic,
                isChecked: isAutomaticTransmissionTypeChecked,
                onChecked: () =>
                    cubit.addTransmissionTypeToSelection(TransmissionType.automatic.name),
                onUnChecked: () =>
                    cubit.removeTransmissionTypeFromSelection(TransmissionType.automatic.name),
              ),

              _buildCheckboxTile(
                semanticsLabel: AppSemanticsLabels.filterDrawerTransmissionTypeCheckbox,
                label: AppLocalisations.transmissionTypeHybrid,
                isChecked: isHybridTransmissionTypeChecked,
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
