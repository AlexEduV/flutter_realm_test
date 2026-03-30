import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:test_futter_project/common/app_colors.dart';
import 'package:test_futter_project/common/app_constants.dart';
import 'package:test_futter_project/common/app_text_styles.dart';
import 'package:test_futter_project/common/enums/body_type.dart';
import 'package:test_futter_project/common/enums/car_type.dart';
import 'package:test_futter_project/common/enums/fuel_type.dart';
import 'package:test_futter_project/common/enums/transmission_type.dart';
import 'package:test_futter_project/presentation/bloc/home/new_item_page/new_item_page_cubit.dart';
import 'package:test_futter_project/presentation/bloc/home/new_item_page/new_item_page_state.dart';
import 'package:test_futter_project/presentation/pages/authentication/widgets/app_form_field.dart';

import '../../../../common/app_dimensions.dart';
import '../../../../common/app_semantics_labels.dart';
import '../../../widgets/app_semantics.dart';

class NewItemPage extends StatefulWidget {
  const NewItemPage({super.key});

  @override
  State<NewItemPage> createState() => _NewItemPageState();
}

class _NewItemPageState extends State<NewItemPage> {
  final pageViewController = PageController();

  final manufacturerFocusNode = FocusNode();
  final modelFocusNode = FocusNode();
  final yearFocusNode = FocusNode();
  final colorFocusNode = FocusNode();

  final manufacturerTextController = TextEditingController();
  final modelTextController = TextEditingController();
  final yearTextController = TextEditingController();
  final colorTextController = TextEditingController();

  CarType? selectedCarType = CarType.car;
  BodyType? selectedBodyType = BodyType.sedan;
  TransmissionType? selectedTransmissionType = TransmissionType.manual;
  FuelType? selectedFuelType = FuelType.diesel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Add new item', style: AppTextStyles.zonaPro20),
        leading: AppSemantics(
          label: AppSemanticsLabels.backButton,
          button: true,
          child: IconButton(
            onPressed: () {
              if (context.canPop()) {
                context.pop();
              }
            },
            icon: const Icon(
              Icons.arrow_back,
              size: AppDimensions.appBarIconSize,
              color: AppColors.headerColor,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsetsGeometry.symmetric(
          vertical: AppDimensions.normalL,
          horizontal: AppDimensions.normalM,
        ),
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: pageViewController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  //page 1
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'What kind of an item would you like to add?',
                        style: AppTextStyles.zonaPro14,
                      ),

                      RadioGroup<CarType>(
                        groupValue: selectedCarType,
                        onChanged: (CarType? value) {
                          setState(() {
                            selectedCarType = value;
                          });
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
                      ),
                    ],
                  ),

                  //page 2
                  BlocBuilder<NewItemPageCubit, NewItemPageState>(
                    builder: (context, state) {
                      return Column(
                        spacing: AppDimensions.normalS,
                        children: [
                          AppFormField(
                            focusNode: manufacturerFocusNode,
                            textEditingController: manufacturerTextController,
                            labelText: state.manufacturerFieldParams?.label ?? '',
                            hintText: state.manufacturerFieldParams?.hintText ?? '',
                            textInputType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                            errorText: state.manufacturerErrorText,
                            onFocusChange: (hasFocus) {
                              if (!hasFocus) {
                                context.read<NewItemPageCubit>().validateManufacturer(
                                  manufacturerTextController.text,
                                  false,
                                );
                              }
                            },
                            onChanged: (newText) {
                              context.read<NewItemPageCubit>().validateManufacturer(
                                manufacturerTextController.text,
                                manufacturerFocusNode.hasFocus,
                              );
                            },
                            padding: 0.0,
                            maxLength: state.manufacturerFieldParams?.maxLength,
                          ),

                          AppFormField(
                            focusNode: modelFocusNode,
                            textEditingController: modelTextController,
                            labelText: state.modelFieldParams?.label ?? '',
                            hintText: state.modelFieldParams?.hintText ?? '',
                            textInputType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                            errorText: state.modelErrorText,
                            onFocusChange: (hasFocus) {
                              if (!hasFocus) {
                                context.read<NewItemPageCubit>().validateModel(
                                  modelTextController.text,
                                  false,
                                );
                              }
                            },
                            onChanged: (newText) {
                              context.read<NewItemPageCubit>().validateModel(
                                modelTextController.text,
                                modelFocusNode.hasFocus,
                              );
                            },
                            padding: 0.0,
                            maxLength: state.modelFieldParams?.maxLength,
                          ),

                          AppFormField(
                            focusNode: yearFocusNode,
                            textEditingController: yearTextController,
                            labelText: state.yearFieldParams?.label ?? '',
                            hintText: state.yearFieldParams?.hintText ?? '',
                            textInputType: TextInputType.number,
                            textInputAction: TextInputAction.next,
                            errorText: state.yearErrorText,
                            onFocusChange: (hasFocus) {
                              if (!hasFocus) {
                                context.read<NewItemPageCubit>().validateYear(
                                  yearTextController.text,
                                  false,
                                );
                              }
                            },
                            onChanged: (newText) {
                              context.read<NewItemPageCubit>().validateYear(
                                yearTextController.text,
                                yearFocusNode.hasFocus,
                              );
                            },
                            padding: 0.0,
                          ),

                          AppFormField(
                            focusNode: colorFocusNode,
                            textEditingController: colorTextController,
                            labelText: state.colorFieldParams?.label ?? '',
                            hintText: state.colorFieldParams?.hintText ?? '',
                            textInputType: TextInputType.text,
                            textInputAction: TextInputAction.done,
                            errorText: state.colorErrorText,
                            onFocusChange: (hasFocus) {
                              if (!hasFocus) {
                                context.read<NewItemPageCubit>().validateColor(
                                  colorTextController.text,
                                  false,
                                );
                              }
                            },
                            onChanged: (newText) {
                              context.read<NewItemPageCubit>().validateColor(
                                colorTextController.text,
                                colorFocusNode.hasFocus,
                              );
                            },
                            padding: 0.0,
                            maxLength: state.colorFieldParams?.maxLength,
                          ),
                        ],
                      );
                    },
                  ),

                  // //page 3
                  // const Text('Body type', style: AppTextStyles.zonaPro14),
                  //
                  // RadioGroup<BodyType>(
                  //   groupValue: selectedBodyType,
                  //   onChanged: (BodyType? value) {
                  //     setState(() {
                  //       selectedBodyType = value;
                  //     });
                  //   },
                  //   child: const Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: <Widget>[
                  //       ListTile(
                  //         title: Text('Sedan'),
                  //         leading: Radio<BodyType>(toggleable: true, value: BodyType.sedan),
                  //       ),
                  //       ListTile(
                  //         title: Text('Coupe'),
                  //         leading: Radio<BodyType>(value: BodyType.coupe),
                  //       ),
                  //       ListTile(
                  //         title: Text('Minivan'),
                  //         leading: Radio<BodyType>(value: BodyType.minivan),
                  //       ),
                  //       ListTile(
                  //         title: Text('Hatchback'),
                  //         leading: Radio<BodyType>(value: BodyType.hatchback),
                  //       ),
                  //       ListTile(
                  //         title: Text('Universal'),
                  //         leading: Radio<BodyType>(value: BodyType.universal),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  //
                  // const Text('Fuel type', style: AppTextStyles.zonaPro14),
                  //
                  // RadioGroup<FuelType>(
                  //   groupValue: selectedFuelType,
                  //   onChanged: (FuelType? value) {
                  //     setState(() {
                  //       selectedFuelType = value;
                  //     });
                  //   },
                  //   child: const Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: <Widget>[
                  //       ListTile(
                  //         title: Text('Diesel'),
                  //         leading: Radio<FuelType>(toggleable: true, value: FuelType.diesel),
                  //       ),
                  //       ListTile(
                  //         title: Text('Gasoline'),
                  //         leading: Radio<FuelType>(value: FuelType.gasoline),
                  //       ),
                  //       ListTile(
                  //         title: Text('EV'),
                  //         leading: Radio<FuelType>(value: FuelType.ev),
                  //       ),
                  //       ListTile(
                  //         title: Text('Hybrid'),
                  //         leading: Radio<FuelType>(value: FuelType.hybrid),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  //
                  // const Text('Transmission type', style: AppTextStyles.zonaPro14),
                  //
                  // RadioGroup<TransmissionType>(
                  //   groupValue: selectedTransmissionType,
                  //   onChanged: (TransmissionType? value) {
                  //     setState(() {
                  //       selectedTransmissionType = value;
                  //     });
                  //   },
                  //   child: const Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: <Widget>[
                  //       ListTile(
                  //         title: Text('Manual'),
                  //         leading: Radio<TransmissionType>(
                  //           toggleable: true,
                  //           value: TransmissionType.manual,
                  //         ),
                  //       ),
                  //       ListTile(
                  //         title: Text('Automatic'),
                  //         leading: Radio<TransmissionType>(value: TransmissionType.automatic),
                  //       ),
                  //       ListTile(
                  //         title: Text('Hybrid'),
                  //         leading: Radio<TransmissionType>(value: TransmissionType.hybrid),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: AppDimensions.minorL,
              children: [
                IconButton(
                  onPressed: () {
                    final cubit = context.read<NewItemPageCubit>();

                    final currentIndex = cubit.state.currentPageIndex;
                    cubit.updateTabIndex(currentIndex - 1);

                    pageViewController.previousPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );

                    clearAllFocuses();
                  },
                  icon: const Icon(Icons.chevron_left_outlined, color: AppColors.headerColor),
                ),
                IconButton(
                  onPressed: () {
                    final cubit = context.read<NewItemPageCubit>();

                    if (cubit.state.currentPageIndex == AppConstants.itemSetupTabInfo) {
                      final areAllFieldsValid = cubit.areAllFieldsValid(
                        manufacturerTextController.text,
                        modelTextController.text,
                        yearTextController.text,
                        colorTextController.text,
                      );

                      if (!areAllFieldsValid) return;
                    }

                    pageViewController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );

                    final currentIndex = cubit.state.currentPageIndex;
                    cubit.updateTabIndex(currentIndex + 1);

                    clearAllFocuses();
                  },
                  icon: const Icon(Icons.chevron_right_outlined, color: AppColors.headerColor),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void clearAllFocuses() {
    manufacturerFocusNode.unfocus();
    modelFocusNode.unfocus();
    yearFocusNode.unfocus();
    colorFocusNode.unfocus();
  }
}
