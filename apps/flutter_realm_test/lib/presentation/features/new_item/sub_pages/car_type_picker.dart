import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_flutter_project/common/extensions/context_extension.dart';
import 'package:test_flutter_project/presentation/features/new_item/new_item_page_cubit.dart';

import '../../../../../common/enums/car_type.dart';
import '../new_item_page_identifiers.dart';
import '../new_item_page_state.dart';
import '../widgets/radio_group_title.dart';

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
        RadioGroupTitle(
          text: context.tr(NewItemPageLocaleKeys.addNewItemTypePickerGroupDescription),
        ),

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
                    title: Text(context.tr(NewItemPageLocaleKeys.addNewItemTypePickerGroupItemCar)),
                    leading: const Radio<CarType>(toggleable: true, value: CarType.car),
                    onTap: () =>
                        context.read<NewItemPageCubit>().updateSelectedCarType(CarType.car),
                    contentPadding: listTileContentPadding,
                  ),
                  ListTile(
                    title: Text(
                      context.tr(NewItemPageLocaleKeys.addNewItemTypePickerGroupItemBike),
                    ),
                    leading: const Radio<CarType>(value: CarType.bike),
                    onTap: () =>
                        context.read<NewItemPageCubit>().updateSelectedCarType(CarType.bike),
                    contentPadding: listTileContentPadding,
                  ),
                  ListTile(
                    title: Text(
                      context.tr(NewItemPageLocaleKeys.addNewItemTypePickerGroupItemTruck),
                    ),
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
