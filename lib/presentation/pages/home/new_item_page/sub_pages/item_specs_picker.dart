import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
        return Column(
          children: [
            const Text('Body type', style: AppTextStyles.zonaPro14),

            RadioGroup<BodyType>(
              groupValue: state.selectedBodyType,
              onChanged: (BodyType? value) {
                context.read<NewItemPageCubit>().updateSelectedBodyType(value);
              },
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ListTile(
                    title: Text('Sedan'),
                    leading: Radio<BodyType>(toggleable: true, value: BodyType.sedan),
                  ),
                  ListTile(
                    title: Text('Coupe'),
                    leading: Radio<BodyType>(value: BodyType.coupe),
                  ),
                  ListTile(
                    title: Text('Minivan'),
                    leading: Radio<BodyType>(value: BodyType.minivan),
                  ),
                  ListTile(
                    title: Text('Hatchback'),
                    leading: Radio<BodyType>(value: BodyType.hatchback),
                  ),
                  ListTile(
                    title: Text('Universal'),
                    leading: Radio<BodyType>(value: BodyType.universal),
                  ),
                ],
              ),
            ),

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
        );
      },
    );
  }
}
