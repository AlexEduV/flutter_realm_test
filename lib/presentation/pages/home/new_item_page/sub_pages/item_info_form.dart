import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_futter_project/utils/dialog_helper.dart';

import '../../../../../common/app_dimensions.dart';
import '../../../../bloc/home/new_item_page/new_item_page_cubit.dart';
import '../../../../bloc/home/new_item_page/new_item_page_state.dart';
import '../../../authentication/widgets/app_form_field.dart';
import '../widgets/radio_group_title.dart';

class ItemInfoForm extends StatefulWidget {
  final FocusNode manufacturerFocusNode;
  final FocusNode modelFocusNode;
  final FocusNode yearFocusNode;
  final FocusNode colorFocusNode;
  final FocusNode priceFocusNode;

  const ItemInfoForm({
    required this.manufacturerFocusNode,
    required this.modelFocusNode,
    required this.yearFocusNode,
    required this.colorFocusNode,
    required this.priceFocusNode,
    super.key,
  });

  @override
  State<ItemInfoForm> createState() => _ItemInfoFormState();
}

class _ItemInfoFormState extends State<ItemInfoForm> {
  final manufacturerTextController = TextEditingController();
  final modelTextController = TextEditingController();
  final yearTextController = TextEditingController();
  final colorTextController = TextEditingController();
  final priceTextController = TextEditingController();

  @override
  void initState() {
    super.initState();

    final cubit = context.read<NewItemPageCubit>();
    cubit.clearFieldErrors();

    manufacturerTextController.text = cubit.state.manufacturerText;
    modelTextController.text = cubit.state.modelText;
    yearTextController.text = cubit.state.yearText;
    colorTextController.text = cubit.state.colorText;
    priceTextController.text = cubit.state.priceText;

    cubit.getAutoCompleteEntitiesByType(cubit.state.selectedCarType);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewItemPageCubit, NewItemPageState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Column(
            spacing: AppDimensions.normalS,
            children: [
              const RadioGroupTitle(text: 'Please, fill the form here.'),

              BlocBuilder<NewItemPageCubit, NewItemPageState>(
                builder: (context, state) {
                  final manufacturers = state.autoCompleteEntities
                      .map((element) => element.manufacturer)
                      .toList();

                  return Autocomplete<String>(
                    optionsBuilder: (TextEditingValue textEditingValue) {
                      if (textEditingValue.text == '') {
                        return const Iterable<String>.empty();
                      }
                      return manufacturers.where((String option) {
                        return option.toLowerCase().contains(textEditingValue.text.toLowerCase());
                      });
                    },
                    fieldViewBuilder:
                        (context, textEditingController, focusNode, onFieldSubmitted) {
                          return AppFormField(
                            focusNode: focusNode,
                            textEditingController: textEditingController,
                            labelText: state.manufacturerFieldParams?.label ?? '',
                            hintText: state.manufacturerFieldParams?.hintText ?? '',
                            textInputType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                            errorText: state.manufacturerErrorText,
                            onFocusChange: (hasFocus) {
                              if (!hasFocus) {
                                context.read<NewItemPageCubit>().validateManufacturer(
                                  textEditingController.text,
                                  false,
                                );
                              }
                            },
                            onChanged: (newText) {
                              context.read<NewItemPageCubit>().validateManufacturer(
                                newText ?? '',
                                focusNode.hasFocus,
                              );

                              context.read<NewItemPageCubit>().updateManufacturerText(
                                textEditingController.text,
                              );
                            },
                            padding: 0.0,
                            maxLength: state.manufacturerFieldParams?.maxLength,
                          );
                        },
                    onSelected: (String selection) {
                      manufacturerTextController.text = selection;
                      context.read<NewItemPageCubit>().updateManufacturerText(selection);
                    },
                  );
                },
              ),

              BlocBuilder<NewItemPageCubit, NewItemPageState>(
                builder: (context, state) {
                  final selectedManufacturer = state.manufacturerText;
                  final models =
                      state.autoCompleteEntities
                          .firstWhereOrNull(
                            (element) => element.manufacturer == selectedManufacturer,
                          )
                          ?.models ??
                      [];

                  return Autocomplete<String>(
                    optionsBuilder: (TextEditingValue textEditingValue) {
                      if (textEditingValue.text == '') {
                        return const Iterable<String>.empty();
                      }
                      return models.where((String option) {
                        return option.toLowerCase().contains(textEditingValue.text.toLowerCase());
                      });
                    },
                    fieldViewBuilder:
                        (context, textEditingController, focusNode, onFieldSubmitted) {
                          return AppFormField(
                            focusNode: focusNode,
                            textEditingController: textEditingController,
                            labelText: state.modelFieldParams?.label ?? '',
                            hintText: state.modelFieldParams?.hintText ?? '',
                            textInputType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                            errorText: state.modelErrorText,
                            onFocusChange: (hasFocus) {
                              if (!hasFocus) {
                                context.read<NewItemPageCubit>().validateModel(
                                  textEditingController.text,
                                  false,
                                );
                              }
                            },
                            onChanged: (newText) {
                              context.read<NewItemPageCubit>().validateModel(
                                textEditingController.text,
                                focusNode.hasFocus,
                              );

                              context.read<NewItemPageCubit>().updateModelText(
                                textEditingController.text,
                              );
                            },
                            padding: 0.0,
                            maxLength: state.modelFieldParams?.maxLength,
                          );
                        },
                    onSelected: (String selection) {
                      modelTextController.text = selection;
                      context.read<NewItemPageCubit>().updateModelText(selection);
                    },
                  );
                },
              ),

              AppFormField(
                focusNode: widget.yearFocusNode,
                textEditingController: yearTextController,
                labelText: state.yearFieldParams?.label ?? '',
                hintText: state.yearFieldParams?.hintText ?? '',
                textInputType: TextInputType.number,
                textInputAction: TextInputAction.next,
                errorText: state.yearErrorText,
                onFocusChange: (hasFocus) {
                  if (!hasFocus) {
                    context.read<NewItemPageCubit>().validateYear(yearTextController.text, false);
                  }
                },
                onChanged: (newText) {
                  context.read<NewItemPageCubit>().validateYear(
                    yearTextController.text,
                    widget.yearFocusNode.hasFocus,
                  );

                  context.read<NewItemPageCubit>().updateYearText(yearTextController.text);
                },
                padding: 0.0,
              ),

              AppFormField(
                focusNode: widget.priceFocusNode,
                textEditingController: priceTextController,
                labelText: state.priceFieldParams?.label ?? '',
                hintText: state.priceFieldParams?.hintText ?? '',
                textInputType: TextInputType.number,
                textInputAction: TextInputAction.next,
                errorText: state.priceErrorText,
                onFocusChange: (hasFocus) {
                  if (!hasFocus) {
                    context.read<NewItemPageCubit>().validatePrice(priceTextController.text, false);
                  }
                },
                onChanged: (newText) {
                  context.read<NewItemPageCubit>().validatePrice(
                    priceTextController.text,
                    widget.priceFocusNode.hasFocus,
                  );

                  context.read<NewItemPageCubit>().updatePriceText(priceTextController.text);
                },
                padding: 0.0,
              ),

              AppFormField(
                focusNode: widget.colorFocusNode,
                textEditingController: colorTextController,
                labelText: state.colorFieldParams?.label ?? '',
                hintText: state.colorFieldParams?.hintText ?? '',
                textInputType: TextInputType.text,
                textInputAction: TextInputAction.done,
                errorText: state.colorErrorText,
                onFocusChange: (hasFocus) {
                  if (!hasFocus) {
                    context.read<NewItemPageCubit>().validateColor(colorTextController.text, false);
                  }
                },
                onChanged: (newText) => onColorChanged(),
                padding: 0.0,
                maxLength: state.colorFieldParams?.maxLength,
                onTap: () async {
                  final color = await DialogHelper.showColorsPickerDialog(
                    context,
                    colorTextController.text,
                  );

                  colorTextController.text = color ?? '';
                  widget.colorFocusNode.unfocus();

                  if (!context.mounted) return;

                  onColorChanged();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void onColorChanged() {
    context.read<NewItemPageCubit>().validateColor(
      colorTextController.text,
      widget.colorFocusNode.hasFocus,
    );

    context.read<NewItemPageCubit>().updateColorText(colorTextController.text);
  }
}
