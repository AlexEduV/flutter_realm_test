import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_futter_project/common/app_dimensions.dart';
import 'package:test_futter_project/common/extensions/context_extension.dart';
import 'package:test_futter_project/presentation/bloc/home/new_item_page/new_item_page_cubit.dart';
import 'package:test_futter_project/presentation/bloc/home/new_item_page/new_item_page_state.dart';
import 'package:test_futter_project/presentation/pages/home/new_item_page/widgets/radio_group_title.dart';

import '../../../../../common/enums/car_type.dart';
import '../../../../../l10n/l10n_keys.dart';

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
        RadioGroupTitle(text: context.tr(L10nKeys.addNewItemTypePickerGroupTitle)),

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
                    title: Text(context.tr(L10nKeys.addNewItemTypePickerGroupItemCar)),
                    leading: const Radio<CarType>(toggleable: true, value: CarType.car),
                    onTap: () =>
                        context.read<NewItemPageCubit>().updateSelectedCarType(CarType.car),
                    contentPadding: listTileContentPadding,
                  ),
                  ListTile(
                    title: Text(context.tr(L10nKeys.addNewItemTypePickerGroupItemBike)),
                    leading: const Radio<CarType>(value: CarType.bike),
                    onTap: () =>
                        context.read<NewItemPageCubit>().updateSelectedCarType(CarType.bike),
                    contentPadding: listTileContentPadding,
                  ),
                  ListTile(
                    title: Text(context.tr(L10nKeys.addNewItemTypePickerGroupItemTruck)),
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
