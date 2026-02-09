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
                        onDebouncedChanged: (value) {
                          context.read<SearchPageCubit>().updateSelectedMinYear(value);
                        },
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
                        onDebouncedChanged: (value) {
                          context.read<SearchPageCubit>().updateSelectedMaxYear(value);
                        },
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
                AppSemantics(
                  label:
                      '${AppSemanticsLabels.filterDrawerBodyTypeCheckbox} ${AppLocalisations.bodyTypeSedan}',
                  isChecked: isSedanBodyTypeChecked,
                  child: CheckboxListTile(
                    title: Text(AppLocalisations.bodyTypeSedan),
                    value: isSedanBodyTypeChecked,
                    onChanged: (bool? newValue) {
                      if (newValue == true) {
                        context.read<SearchPageCubit>().addBodyTypeToSelection(BodyType.sedan.name);
                      } else {
                        context.read<SearchPageCubit>().removeBodyTypeFromSelection(
                          BodyType.sedan.name,
                        );
                      }
                    },
                    controlAffinity: checkBoxPosition,
                  ),
                ),
                AppSemantics(
                  label:
                      '${AppSemanticsLabels.filterDrawerBodyTypeCheckbox} ${AppLocalisations.bodyTypeHatchback}',
                  isChecked: isHatchbackBodyTypeChecked,
                  child: CheckboxListTile(
                    title: Text(AppLocalisations.bodyTypeHatchback),
                    value: isHatchbackBodyTypeChecked,
                    onChanged: (bool? newValue) {
                      if (newValue == true) {
                        context.read<SearchPageCubit>().addBodyTypeToSelection(
                          BodyType.hatchback.name,
                        );
                      } else {
                        context.read<SearchPageCubit>().removeBodyTypeFromSelection(
                          BodyType.hatchback.name,
                        );
                      }
                    },
                    controlAffinity: checkBoxPosition,
                  ),
                ),
                AppSemantics(
                  label:
                      '${AppSemanticsLabels.filterDrawerBodyTypeCheckbox} ${AppLocalisations.bodyTypeUniversal}',
                  isChecked: isUniversalBodyTypeChecked,
                  child: CheckboxListTile(
                    title: Text(AppLocalisations.bodyTypeUniversal),
                    value: isUniversalBodyTypeChecked,
                    onChanged: (bool? newValue) {
                      if (newValue == true) {
                        context.read<SearchPageCubit>().addBodyTypeToSelection(
                          BodyType.universal.name,
                        );
                      } else {
                        context.read<SearchPageCubit>().removeBodyTypeFromSelection(
                          BodyType.universal.name,
                        );
                      }
                    },
                    controlAffinity: checkBoxPosition,
                  ),
                ),
                AppSemantics(
                  label:
                      '${AppSemanticsLabels.filterDrawerBodyTypeCheckbox} ${AppLocalisations.bodyTypeMinivan}',
                  isChecked: isMinivanBodyTypeChecked,
                  child: CheckboxListTile(
                    title: Text(AppLocalisations.bodyTypeMinivan),
                    value: isMinivanBodyTypeChecked,
                    onChanged: (bool? newValue) {
                      if (newValue == true) {
                        context.read<SearchPageCubit>().addBodyTypeToSelection(
                          BodyType.minivan.name,
                        );
                      } else {
                        context.read<SearchPageCubit>().removeBodyTypeFromSelection(
                          BodyType.minivan.name,
                        );
                      }
                    },
                    controlAffinity: checkBoxPosition,
                  ),
                ),
                AppSemantics(
                  label:
                      '${AppSemanticsLabels.filterDrawerBodyTypeCheckbox} ${AppLocalisations.bodyTypeCoupe}',
                  isChecked: isCoupeBodyTypeChecked,
                  child: CheckboxListTile(
                    title: Text(AppLocalisations.bodyTypeCoupe),
                    value: isCoupeBodyTypeChecked,
                    onChanged: (bool? newValue) {
                      if (newValue == true) {
                        context.read<SearchPageCubit>().addBodyTypeToSelection(BodyType.coupe.name);
                      } else {
                        context.read<SearchPageCubit>().removeBodyTypeFromSelection(
                          BodyType.coupe.name,
                        );
                      }
                    },
                    controlAffinity: checkBoxPosition,
                  ),
                ),
                AppSemantics(
                  label:
                      '${AppSemanticsLabels.filterDrawerBodyTypeCheckbox} ${AppLocalisations.bodyTypeCrossover}',
                  isChecked: isCrossoverBodyTypeChecked,
                  child: CheckboxListTile(
                    title: Text(AppLocalisations.bodyTypeCrossover),
                    value: isCoupeBodyTypeChecked,
                    onChanged: (bool? newValue) {
                      if (newValue == true) {
                        context.read<SearchPageCubit>().addBodyTypeToSelection(
                          BodyType.crossover.name,
                        );
                      } else {
                        context.read<SearchPageCubit>().removeBodyTypeFromSelection(
                          BodyType.crossover.name,
                        );
                      }
                    },
                    controlAffinity: checkBoxPosition,
                  ),
                ),
              ] else if (state.currentSelectedType == CarType.truck) ...[
                AppSemantics(
                  label:
                      '${AppSemanticsLabels.filterDrawerBodyTypeCheckbox} ${AppLocalisations.bodyTypeSemi}',
                  isChecked: isSemiBodyTypeChecked,
                  child: CheckboxListTile(
                    title: Text(AppLocalisations.bodyTypeSemi),
                    value: isSemiBodyTypeChecked,
                    onChanged: (bool? newValue) {
                      if (newValue == true) {
                        context.read<SearchPageCubit>().addBodyTypeToSelection(BodyType.semi.name);
                      } else {
                        context.read<SearchPageCubit>().removeBodyTypeFromSelection(
                          BodyType.semi.name,
                        );
                      }
                    },
                    controlAffinity: checkBoxPosition,
                  ),
                ),
              ] else ...[
                AppSemantics(
                  label:
                      '${AppSemanticsLabels.filterDrawerBodyTypeCheckbox} ${AppLocalisations.bodyTypeBike}',
                  isChecked: isBikeBodyTypeChecked,
                  child: CheckboxListTile(
                    title: Text(AppLocalisations.bodyTypeBike),
                    value: isBikeBodyTypeChecked,
                    onChanged: (bool? newValue) {
                      if (newValue == true) {
                        context.read<SearchPageCubit>().addBodyTypeToSelection(BodyType.bike.name);
                      } else {
                        context.read<SearchPageCubit>().removeBodyTypeFromSelection(
                          BodyType.bike.name,
                        );
                      }
                    },
                    controlAffinity: checkBoxPosition,
                  ),
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
                        onDebouncedChanged: (newValue) {
                          context.read<SearchPageCubit>().updateSelectedMinPrice(newValue);
                        },
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
                        onDebouncedChanged: (newValue) {
                          context.read<SearchPageCubit>().updateSelectedMaxPrice(newValue);
                        },
                        errorText: state.maxPriceError,
                      ),
                    ),
                  ),
                ],
              ),

              ListTile(
                title: Text(AppLocalisations.parameterFuelTypeName, style: AppTextStyles.zonaPro18),
              ),

              AppSemantics(
                label:
                    '${AppSemanticsLabels.filterDrawerFuelTypeCheckbox} ${AppLocalisations.fuelTypeDiesel}',
                isChecked: isDieselFuelTypeChecked,
                child: CheckboxListTile(
                  title: Text(AppLocalisations.fuelTypeDiesel),
                  value: isDieselFuelTypeChecked,
                  onChanged: (bool? newValue) {
                    if (newValue == true) {
                      context.read<SearchPageCubit>().addFuelTypeToSelection(FuelType.diesel.name);
                    } else {
                      context.read<SearchPageCubit>().removeFuelTypeFromSelection(
                        FuelType.diesel.name,
                      );
                    }
                  },
                  controlAffinity: checkBoxPosition,
                ),
              ),
              AppSemantics(
                label:
                    '${AppSemanticsLabels.filterDrawerFuelTypeCheckbox} ${AppLocalisations.fuelTypeGasoline}',
                isChecked: isGasolineFuelTypeChecked,
                child: CheckboxListTile(
                  title: Text(AppLocalisations.fuelTypeGasoline),
                  value: isGasolineFuelTypeChecked,
                  onChanged: (bool? newValue) {
                    if (newValue == true) {
                      context.read<SearchPageCubit>().addFuelTypeToSelection(
                        FuelType.gasoline.name,
                      );
                    } else {
                      context.read<SearchPageCubit>().removeFuelTypeFromSelection(
                        FuelType.gasoline.name,
                      );
                    }
                  },
                  controlAffinity: checkBoxPosition,
                ),
              ),
              AppSemantics(
                label:
                    '${AppSemanticsLabels.filterDrawerFuelTypeCheckbox} ${AppLocalisations.fuelTypeEv}',
                isChecked: isEvFuelTypeChecked,
                child: CheckboxListTile(
                  title: Text(AppLocalisations.fuelTypeEv),
                  value: isEvFuelTypeChecked,
                  onChanged: (bool? newValue) {
                    if (newValue == true) {
                      context.read<SearchPageCubit>().addFuelTypeToSelection(FuelType.ev.name);
                    } else {
                      context.read<SearchPageCubit>().removeFuelTypeFromSelection(FuelType.ev.name);
                    }
                  },
                  controlAffinity: checkBoxPosition,
                ),
              ),
              AppSemantics(
                label:
                    '${AppSemanticsLabels.filterDrawerFuelTypeCheckbox} ${AppLocalisations.fuelTypeHybrid}',
                isChecked: isHybridFuelTypeChecked,
                child: CheckboxListTile(
                  title: Text(AppLocalisations.fuelTypeHybrid),
                  value: isHybridFuelTypeChecked,
                  onChanged: (bool? newValue) {
                    if (newValue == true) {
                      context.read<SearchPageCubit>().addFuelTypeToSelection(FuelType.hybrid.name);
                    } else {
                      context.read<SearchPageCubit>().removeFuelTypeFromSelection(
                        FuelType.hybrid.name,
                      );
                    }
                  },
                  controlAffinity: checkBoxPosition,
                ),
              ),

              ListTile(
                title: Text(
                  AppLocalisations.parameterTransmissionTypeName,
                  style: AppTextStyles.zonaPro18,
                ),
              ),

              AppSemantics(
                label:
                    '${AppSemanticsLabels.filterDrawerTransmissionTypeCheckbox} ${AppLocalisations.transmissionTypeManual}',
                isChecked: isManualTransmissionTypeChecked,
                child: CheckboxListTile(
                  title: Text(AppLocalisations.transmissionTypeManual),
                  value: isManualTransmissionTypeChecked,
                  onChanged: (bool? newValue) {
                    if (newValue == true) {
                      context.read<SearchPageCubit>().addTransmissionTypeToSelection(
                        TransmissionType.manual.name,
                      );
                    } else {
                      context.read<SearchPageCubit>().removeTransmissionTypeFromSelection(
                        TransmissionType.manual.name,
                      );
                    }
                  },
                  controlAffinity: checkBoxPosition,
                ),
              ),
              AppSemantics(
                label:
                    '${AppSemanticsLabels.filterDrawerTransmissionTypeCheckbox} ${AppLocalisations.transmissionTypeAutomatic}',
                isChecked: isAutomaticTransmissionTypeChecked,
                child: CheckboxListTile(
                  title: Text(AppLocalisations.transmissionTypeAutomatic),
                  value: isAutomaticTransmissionTypeChecked,
                  onChanged: (bool? newValue) {
                    if (newValue == true) {
                      context.read<SearchPageCubit>().addTransmissionTypeToSelection(
                        TransmissionType.automatic.name,
                      );
                    } else {
                      context.read<SearchPageCubit>().removeTransmissionTypeFromSelection(
                        TransmissionType.automatic.name,
                      );
                    }
                  },
                  controlAffinity: checkBoxPosition,
                ),
              ),
              AppSemantics(
                label:
                    '${AppSemanticsLabels.filterDrawerTransmissionTypeCheckbox} ${AppLocalisations.transmissionTypeHybrid}',
                isChecked: isHybridTransmissionTypeChecked,
                child: CheckboxListTile(
                  title: Text(AppLocalisations.transmissionTypeHybrid),
                  value: isHybridTransmissionTypeChecked,
                  onChanged: (bool? newValue) {
                    if (newValue == true) {
                      context.read<SearchPageCubit>().addTransmissionTypeToSelection(
                        TransmissionType.hybrid.name,
                      );
                    } else {
                      context.read<SearchPageCubit>().removeTransmissionTypeFromSelection(
                        TransmissionType.hybrid.name,
                      );
                    }
                  },
                  controlAffinity: checkBoxPosition,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
