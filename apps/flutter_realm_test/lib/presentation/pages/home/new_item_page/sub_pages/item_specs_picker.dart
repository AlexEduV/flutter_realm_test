import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_flutter_project/common/constants/app_dimensions.dart';
import 'package:test_flutter_project/common/extensions/context_extension.dart';
import 'package:test_flutter_project/presentation/bloc/home/new_item_page/new_item_page_cubit.dart';
import 'package:test_flutter_project/presentation/bloc/home/new_item_page/new_item_page_state.dart';

import '../../../../../common/enums/body_type.dart';
import '../../../../../common/enums/fuel_type.dart';
import '../../../../../common/enums/transmission_type.dart';
import '../../../../../l10n/l10n_keys.dart';
import '../widgets/radio_group_title.dart';

class ItemSpecsPicker extends StatefulWidget {
  const ItemSpecsPicker({super.key});

  @override
  State<ItemSpecsPicker> createState() => _ItemSpecsPickerState();
}

class _ItemSpecsPickerState extends State<ItemSpecsPicker> {
  List<BodyType> bodyTypesList = [];

  @override
  void initState() {
    super.initState();

    final cubit = context.read<NewItemPageCubit>();
    bodyTypesList = BodyType.filterByCarType(cubit.state.selectedCarType);
    cubit.updateSelectedBodyType(bodyTypesList.firstOrNull);
  }

  @override
  Widget build(BuildContext context) {
    final listTileContentPadding = const EdgeInsets.symmetric(horizontal: AppDimensions.minorS);

    return BlocBuilder<NewItemPageCubit, NewItemPageState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Column(
            spacing: AppDimensions.minorL,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RadioGroupTitle(
                    text: context.tr(L10nKeys.addNewItemSpecsPickerBodyTypeGroupDescription),
                  ),

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
                              title: Text(element.fromLocalisations()),
                              leading: Radio<BodyType>(toggleable: true, value: element),
                              contentPadding: listTileContentPadding,
                              onTap: () =>
                                  context.read<NewItemPageCubit>().updateSelectedBodyType(element),
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
                  RadioGroupTitle(
                    text: context.tr(L10nKeys.addNewItemSpecsPickerFuelTypeGroupDescription),
                  ),

                  RadioGroup<FuelType>(
                    groupValue: state.selectedFuelType,
                    onChanged: (FuelType? value) {
                      context.read<NewItemPageCubit>().updateSelectedFuelType(value);
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        ListTile(
                          title: Text(
                            context.tr(L10nKeys.addNewItemSpecsPickerFuelTypeGroupItemDiesel),
                          ),
                          leading: const Radio<FuelType>(toggleable: true, value: FuelType.diesel),
                          contentPadding: listTileContentPadding,
                          onTap: () => context.read<NewItemPageCubit>().updateSelectedFuelType(
                            FuelType.diesel,
                          ),
                        ),
                        ListTile(
                          title: Text(
                            context.tr(L10nKeys.addNewItemSpecsPickerFuelTypeGroupItemGasoline),
                          ),
                          leading: const Radio<FuelType>(value: FuelType.gasoline),
                          contentPadding: listTileContentPadding,
                          onTap: () => context.read<NewItemPageCubit>().updateSelectedFuelType(
                            FuelType.gasoline,
                          ),
                        ),
                        ListTile(
                          title: Text(
                            context.tr(L10nKeys.addNewItemSpecsPickerFuelTypeGroupItemEV),
                          ),
                          leading: const Radio<FuelType>(value: FuelType.ev),
                          contentPadding: listTileContentPadding,
                          onTap: () =>
                              context.read<NewItemPageCubit>().updateSelectedFuelType(FuelType.ev),
                        ),
                        ListTile(
                          title: Text(
                            context.tr(L10nKeys.addNewItemSpecsPickerFuelTypeGroupItemHybrid),
                          ),
                          leading: const Radio<FuelType>(value: FuelType.hybrid),
                          contentPadding: listTileContentPadding,
                          onTap: () => context.read<NewItemPageCubit>().updateSelectedFuelType(
                            FuelType.hybrid,
                          ),
                        ),
                      ],
                    ),
                  ),

                  //todo: add a text field here based on the selected fuel type
                ],
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RadioGroupTitle(
                    text: context.tr(
                      L10nKeys.addNewItemSpecsPickerTransmissionTypeGroupDescription,
                    ),
                  ),

                  RadioGroup<TransmissionType>(
                    groupValue: state.selectedTransmissionType,
                    onChanged: (TransmissionType? value) {
                      context.read<NewItemPageCubit>().updateSelectedTransmissionType(value);
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        ListTile(
                          title: Text(
                            context.tr(
                              L10nKeys.addNewItemSpecsPickerTransmissionTypeGroupItemManual,
                            ),
                          ),
                          leading: const Radio<TransmissionType>(
                            toggleable: true,
                            value: TransmissionType.manual,
                          ),
                          contentPadding: listTileContentPadding,
                          onTap: () => context
                              .read<NewItemPageCubit>()
                              .updateSelectedTransmissionType(TransmissionType.manual),
                        ),
                        ListTile(
                          title: Text(
                            context.tr(
                              L10nKeys.addNewItemSpecsPickerTransmissionTypeGroupItemAutomatic,
                            ),
                          ),
                          leading: const Radio<TransmissionType>(value: TransmissionType.automatic),
                          contentPadding: listTileContentPadding,
                          onTap: () => context
                              .read<NewItemPageCubit>()
                              .updateSelectedTransmissionType(TransmissionType.automatic),
                        ),
                        ListTile(
                          title: Text(
                            context.tr(
                              L10nKeys.addNewItemSpecsPickerTransmissionTypeGroupItemHybrid,
                            ),
                          ),
                          leading: const Radio<TransmissionType>(value: TransmissionType.hybrid),
                          contentPadding: listTileContentPadding,
                          onTap: () => context
                              .read<NewItemPageCubit>()
                              .updateSelectedTransmissionType(TransmissionType.hybrid),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: AppDimensions.majorXL * 2),
            ],
          ),
        );
      },
    );
  }
}
