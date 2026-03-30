import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_futter_project/presentation/bloc/home/new_item_page/new_item_page_cubit.dart';
import 'package:test_futter_project/presentation/bloc/home/new_item_page/new_item_page_state.dart';

import '../../../../../common/app_text_styles.dart';
import '../../../../../common/enums/car_type.dart';

class CarTypePicker extends StatefulWidget {
  const CarTypePicker({super.key});

  @override
  State<CarTypePicker> createState() => _CarTypePickerState();
}

class _CarTypePickerState extends State<CarTypePicker> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('What kind of an item would you like to add?', style: AppTextStyles.zonaPro14),

        BlocBuilder<NewItemPageCubit, NewItemPageState>(
          builder: (context, state) {
            return RadioGroup<CarType>(
              groupValue: state.selectedCarType,
              onChanged: (CarType? value) {
                context.read<NewItemPageCubit>().updateSelectedCarType(value);
              },
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ListTile(
                    title: Text('Car'),
                    leading: Radio<CarType>(toggleable: true, value: CarType.car),
                  ),
                  ListTile(
                    title: Text('Bike'),
                    leading: Radio<CarType>(value: CarType.bike),
                  ),
                  ListTile(
                    title: Text('Truck'),
                    leading: Radio<CarType>(value: CarType.truck),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
