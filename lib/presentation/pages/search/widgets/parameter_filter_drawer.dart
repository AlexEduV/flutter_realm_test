import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_futter_project/common/app_colors.dart';
import 'package:test_futter_project/common/app_dimensions.dart';
import 'package:test_futter_project/common/app_text_styles.dart';
import 'package:test_futter_project/common/enums/body_type.dart';
import 'package:test_futter_project/common/enums/car_type.dart';
import 'package:test_futter_project/domain/models/field_params_model.dart';
import 'package:test_futter_project/presentation/bloc/search/search_page_cubit.dart';
import 'package:test_futter_project/presentation/bloc/search/search_page_state.dart';
import 'package:test_futter_project/utils/l10n.dart';

class ParameterFilterDrawer extends StatefulWidget {
  const ParameterFilterDrawer({super.key});

  @override
  State<ParameterFilterDrawer> createState() => _ParameterFilterDrawerState();
}

class _ParameterFilterDrawerState extends State<ParameterFilterDrawer> {
  final minYearTextController = TextEditingController();
  final maxYearTextController = TextEditingController();

  final minPriceTextController = TextEditingController();
  final maxPriceTextController = TextEditingController();

  final checkBoxPosition = ListTileControlAffinity.leading;

  //todo: business logic is not ready;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchPageCubit, SearchPageState>(
      builder: (context, state) {
        final selectedBodyTypeSet = Set<String>.from(state.selectedBodyTypes);

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
                    child: _buildFormField(
                      minYearTextController,
                      FieldParamsModel.withLabel('Min:'),
                    ),
                  ),
                  Expanded(
                    child: _buildFormField(
                      maxYearTextController,
                      FieldParamsModel.withLabel('Max:'),
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
                    if (newValue ?? false) {
                      context.read<SearchPageCubit>().removeBodyTypeFromSelection(
                        BodyType.sedan.name,
                      );
                    } else {
                      context.read<SearchPageCubit>().addBodyTypeToSelection(BodyType.sedan.name);
                    }
                  },
                  controlAffinity: checkBoxPosition,
                ),
                CheckboxListTile(
                  title: const Text('Hatchback'),
                  value: selectedBodyTypeSet.contains(BodyType.hatchback.name),
                  onChanged: (bool? newValue) {
                    if (newValue ?? false) {
                      context.read<SearchPageCubit>().removeBodyTypeFromSelection(
                        BodyType.hatchback.name,
                      );
                    } else {
                      context.read<SearchPageCubit>().addBodyTypeToSelection(
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
                    if (newValue ?? false) {
                      context.read<SearchPageCubit>().removeBodyTypeFromSelection(
                        BodyType.universal.name,
                      );
                    } else {
                      context.read<SearchPageCubit>().addBodyTypeToSelection(
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
                    if (newValue ?? false) {
                      context.read<SearchPageCubit>().removeBodyTypeFromSelection(
                        BodyType.minivan.name,
                      );
                    } else {
                      context.read<SearchPageCubit>().addBodyTypeToSelection(BodyType.minivan.name);
                    }
                  },
                  controlAffinity: checkBoxPosition,
                ),
                CheckboxListTile(
                  title: const Text('Coupe'),
                  value: selectedBodyTypeSet.contains(BodyType.coupe.name),
                  onChanged: (bool? newValue) {
                    if (newValue ?? false) {
                      context.read<SearchPageCubit>().removeBodyTypeFromSelection(
                        BodyType.coupe.name,
                      );
                    } else {
                      context.read<SearchPageCubit>().addBodyTypeToSelection(BodyType.coupe.name);
                    }
                  },
                  controlAffinity: checkBoxPosition,
                ),
                CheckboxListTile(
                  title: const Text('Cross-over'),
                  value: selectedBodyTypeSet.contains(BodyType.crossover.name),
                  onChanged: (bool? newValue) {
                    if (newValue ?? false) {
                      context.read<SearchPageCubit>().removeBodyTypeFromSelection(
                        BodyType.crossover.name,
                      );
                    } else {
                      context.read<SearchPageCubit>().addBodyTypeToSelection(
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
                    if (newValue ?? false) {
                      context.read<SearchPageCubit>().removeBodyTypeFromSelection(
                        BodyType.semi.name,
                      );
                    } else {
                      context.read<SearchPageCubit>().addBodyTypeToSelection(BodyType.semi.name);
                    }
                  },
                  controlAffinity: checkBoxPosition,
                ),
              ] else ...[
                CheckboxListTile(
                  title: const Text('Bike'),
                  value: selectedBodyTypeSet.contains(BodyType.bike.name),
                  onChanged: (bool? newValue) {
                    if (newValue ?? false) {
                      context.read<SearchPageCubit>().removeBodyTypeFromSelection(
                        BodyType.bike.name,
                      );
                    } else {
                      context.read<SearchPageCubit>().addBodyTypeToSelection(BodyType.bike.name);
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
                    child: _buildFormField(
                      minPriceTextController,
                      FieldParamsModel.withLabel('Min:'),
                    ),
                  ),
                  Expanded(
                    child: _buildFormField(
                      maxPriceTextController,
                      FieldParamsModel.withLabel('Max:'),
                    ),
                  ),
                ],
              ),

              ListTile(
                title: Text(AppLocalisations.parameterFuelTypeName, style: AppTextStyles.zonaPro18),
              ),

              CheckboxListTile(
                title: const Text('Diesel'),
                value: false,
                onChanged: (bool? newValue) {},
                controlAffinity: checkBoxPosition,
              ),
              CheckboxListTile(
                title: const Text('Gasoline'),
                value: false,
                onChanged: (bool? newValue) {},
                controlAffinity: checkBoxPosition,
              ),
              CheckboxListTile(
                title: const Text('EV'),
                value: false,
                onChanged: (bool? newValue) {},
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
                value: false,
                onChanged: (bool? newValue) {},
                controlAffinity: checkBoxPosition,
              ),
              CheckboxListTile(
                title: const Text('Automatic'),
                value: false,
                onChanged: (bool? newValue) {},
                controlAffinity: checkBoxPosition,
              ),
              CheckboxListTile(
                title: const Text('Hybrid'),
                value: false,
                onChanged: (bool? newValue) {},
                controlAffinity: checkBoxPosition,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFormField(TextEditingController controller, FieldParamsModel model) {
    return Padding(
      padding: const EdgeInsets.all(AppDimensions.normalS),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          labelText: model.label,
          border: const OutlineInputBorder(borderSide: BorderSide(color: AppColors.accentColor)),
        ),
        keyboardType: TextInputType.number,
      ),
    );
  }
}
