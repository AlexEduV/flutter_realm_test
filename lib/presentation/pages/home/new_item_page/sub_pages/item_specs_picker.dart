import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_futter_project/common/app_dimensions.dart';
import 'package:test_futter_project/common/extensions/string_extension.dart';
import 'package:test_futter_project/presentation/bloc/home/new_item_page/new_item_page_cubit.dart';
import 'package:test_futter_project/presentation/bloc/home/new_item_page/new_item_page_state.dart';

import '../../../../../common/app_text_styles.dart';
import '../../../../../common/enums/body_type.dart';
import '../../../../../common/enums/fuel_type.dart';
import '../../../../../common/enums/transmission_type.dart';

class ItemSpecsPicker extends StatefulWidget {
  const ItemSpecsPicker({super.key});

  @override
  State<ItemSpecsPicker> createState() => _ItemSpecsPickerState();
}

class _ItemSpecsPickerState extends State<ItemSpecsPicker> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewItemPageCubit, NewItemPageState>(
      builder: (context, state) {
        final bodyTypesList = carTypeToBodyTypes[state.selectedCarType] ?? [];

        return SingleChildScrollView(
          child: Column(
            spacing: AppDimensions.minorL,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Body type', style: AppTextStyles.zonaPro14),

                  RadioGroup<BodyType>(
                    groupValue: state.selectedBodyType,
                    onChanged: (BodyType? value) {
                      context.read<NewItemPageCubit>().updateSelectedBodyType(value);
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: bodyTypesList
                          .map(
                            (element) => ListTile(
                              title: Text(element.name.capitalizeFirst()),
                              leading: Radio<BodyType>(toggleable: true, value: element),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ],
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Fuel type', style: AppTextStyles.zonaPro14),

                  RadioGroup<FuelType>(
                    groupValue: state.selectedFuelType,
                    onChanged: (FuelType? value) {
                      context.read<NewItemPageCubit>().updateSelectedFuelType(value);
                    },
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        ListTile(
                          title: Text('Diesel'),
                          leading: Radio<FuelType>(toggleable: true, value: FuelType.diesel),
                        ),
                        ListTile(
                          title: Text('Gasoline'),
                          leading: Radio<FuelType>(value: FuelType.gasoline),
                        ),
                        ListTile(
                          title: Text('EV'),
                          leading: Radio<FuelType>(value: FuelType.ev),
                        ),
                        ListTile(
                          title: Text('Hybrid'),
                          leading: Radio<FuelType>(value: FuelType.hybrid),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Transmission type', style: AppTextStyles.zonaPro14),

                  RadioGroup<TransmissionType>(
                    groupValue: state.selectedTransmissionType,
                    onChanged: (TransmissionType? value) {
                      context.read<NewItemPageCubit>().updateSelectedTransmissionType(value);
                    },
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        ListTile(
                          title: Text('Manual'),
                          leading: Radio<TransmissionType>(
                            toggleable: true,
                            value: TransmissionType.manual,
                          ),
                        ),
                        ListTile(
                          title: Text('Automatic'),
                          leading: Radio<TransmissionType>(value: TransmissionType.automatic),
                        ),
                        ListTile(
                          title: Text('Hybrid'),
                          leading: Radio<TransmissionType>(value: TransmissionType.hybrid),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
