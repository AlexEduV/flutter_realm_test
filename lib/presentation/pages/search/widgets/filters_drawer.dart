import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_futter_project/common/app_colors.dart';
import 'package:test_futter_project/common/app_dimensions.dart';
import 'package:test_futter_project/common/app_text_styles.dart';
import 'package:test_futter_project/common/enums/body_type.dart';
import 'package:test_futter_project/common/enums/car_type.dart';
import 'package:test_futter_project/common/enums/fuel_type.dart';
import 'package:test_futter_project/common/enums/transmission_type.dart';
import 'package:test_futter_project/presentation/bloc/search/search_page_cubit.dart';
import 'package:test_futter_project/presentation/bloc/search/search_page_state.dart';
import 'package:test_futter_project/presentation/pages/search/widgets/debounced_text_form_field.dart';
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

    minYearTextController.text = context.read<SearchPageCubit>().state.selectedMinYear ?? '';
    maxYearTextController.text = context.read<SearchPageCubit>().state.selectedMaxYear ?? '';
    minPriceTextController.text = context.read<SearchPageCubit>().state.selectedMinPrice ?? '';
    maxPriceTextController.text = context.read<SearchPageCubit>().state.selectedMaxPrice ?? '';
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

              //todo: add localisations for the texts
              if (state.currentSelectedType == CarType.car) ...[
                CheckboxListTile(
                  title: const Text('Sedan'),
                  value: selectedBodyTypeSet.contains(BodyType.sedan.name),
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
                CheckboxListTile(
                  title: const Text('Hatchback'),
                  value: selectedBodyTypeSet.contains(BodyType.hatchback.name),
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
                CheckboxListTile(
                  title: const Text('Universal'),
                  value: selectedBodyTypeSet.contains(BodyType.universal.name),
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
                CheckboxListTile(
                  title: const Text('Minivan'),
                  value: selectedBodyTypeSet.contains(BodyType.minivan.name),
                  onChanged: (bool? newValue) {
                    if (newValue == true) {
                      context.read<SearchPageCubit>().addBodyTypeToSelection(BodyType.minivan.name);
                    } else {
                      context.read<SearchPageCubit>().removeBodyTypeFromSelection(
                        BodyType.minivan.name,
                      );
                    }
                  },
                  controlAffinity: checkBoxPosition,
                ),
                CheckboxListTile(
                  title: const Text('Coupe'),
                  value: selectedBodyTypeSet.contains(BodyType.coupe.name),
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
                CheckboxListTile(
                  title: const Text('Cross-over'),
                  value: selectedBodyTypeSet.contains(BodyType.crossover.name),
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
              ] else if (state.currentSelectedType == CarType.truck) ...[
                CheckboxListTile(
                  title: const Text('Semi'),
                  value: selectedBodyTypeSet.contains(BodyType.semi.name),
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
              ] else ...[
                CheckboxListTile(
                  title: const Text('Bike'),
                  value: selectedBodyTypeSet.contains(BodyType.bike.name),
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

              CheckboxListTile(
                title: const Text('Diesel'),
                value: selectedFuelTypeSet.contains(FuelType.diesel.name),
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
              CheckboxListTile(
                title: const Text('Gasoline'),
                value: selectedFuelTypeSet.contains(FuelType.gasoline.name),
                onChanged: (bool? newValue) {
                  if (newValue == true) {
                    context.read<SearchPageCubit>().addFuelTypeToSelection(FuelType.gasoline.name);
                  } else {
                    context.read<SearchPageCubit>().removeFuelTypeFromSelection(
                      FuelType.gasoline.name,
                    );
                  }
                },
                controlAffinity: checkBoxPosition,
              ),
              CheckboxListTile(
                title: const Text('EV'),
                value: selectedFuelTypeSet.contains(FuelType.ev.name),
                onChanged: (bool? newValue) {
                  if (newValue == true) {
                    context.read<SearchPageCubit>().addFuelTypeToSelection(FuelType.ev.name);
                  } else {
                    context.read<SearchPageCubit>().removeFuelTypeFromSelection(FuelType.ev.name);
                  }
                },
                controlAffinity: checkBoxPosition,
              ),
              CheckboxListTile(
                title: const Text('Hybrid'),
                value: selectedFuelTypeSet.contains(FuelType.hybrid.name),
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

              ListTile(
                title: Text(
                  AppLocalisations.parameterTransmissionTypeName,
                  style: AppTextStyles.zonaPro18,
                ),
              ),

              CheckboxListTile(
                title: const Text('Manual'),
                value: selectedTransmissionTypeSet.contains(TransmissionType.manual.name),
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
              CheckboxListTile(
                title: const Text('Automatic'),
                value: selectedTransmissionTypeSet.contains(TransmissionType.automatic.name),
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
              CheckboxListTile(
                title: const Text('Hybrid'),
                value: selectedTransmissionTypeSet.contains(TransmissionType.hybrid.name),
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
            ],
          ),
        );
      },
    );
  }
}
