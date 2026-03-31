import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_futter_project/common/app_dimensions.dart';
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
    const listTileContentPadding = EdgeInsets.symmetric(horizontal: AppDimensions.minorS);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppDimensions.minorS,
      children: [
        const Text('What kind of an item would you like to add?', style: AppTextStyles.zonaPro14),

        BlocBuilder<NewItemPageCubit, NewItemPageState>(
          builder: (context, state) {
            return RadioGroup<CarType>(
              groupValue: state.selectedCarType,
              onChanged: (CarType? value) {
                context.read<NewItemPageCubit>().updateSelectedCarType(value);
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ListTile(
                    title: const Text('Car'),
                    leading: const Radio<CarType>(toggleable: true, value: CarType.car),
                    onTap: () =>
                        context.read<NewItemPageCubit>().updateSelectedCarType(CarType.car),
                    contentPadding: listTileContentPadding,
                  ),
                  ListTile(
                    title: const Text('Bike'),
                    leading: const Radio<CarType>(value: CarType.bike),
                    onTap: () =>
                        context.read<NewItemPageCubit>().updateSelectedCarType(CarType.bike),
                    contentPadding: listTileContentPadding,
                  ),
                  ListTile(
                    title: const Text('Truck'),
                    leading: const Radio<CarType>(value: CarType.truck),
                    onTap: () =>
                        context.read<NewItemPageCubit>().updateSelectedCarType(CarType.truck),
                    contentPadding: listTileContentPadding,
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
