import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:test_futter_project/common/app_colors.dart';
import 'package:test_futter_project/common/app_text_styles.dart';
import 'package:test_futter_project/common/enums/body_type.dart';
import 'package:test_futter_project/common/enums/car_type.dart';
import 'package:test_futter_project/common/enums/fuel_type.dart';
import 'package:test_futter_project/common/enums/transmission_type.dart';
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
        child: SingleChildScrollView(
          child: Column(
            spacing: AppDimensions.normalS,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'What kind of an item would you like to add?',
                style: AppTextStyles.zonaPro14,
              ),

              //page view page 1
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

              //page 2
              AppFormField(
                focusNode: manufacturerFocusNode,
                textEditingController: manufacturerTextController,
                labelText: 'Manufacturer',
                hintText: 'Manufacturer',
                textInputType: TextInputType.text,
                textInputAction: TextInputAction.next,
                onFocusChange: (hasFocus) {},
                onChanged: (newText) {},
                padding: 0.0,
              ),

              AppFormField(
                focusNode: modelFocusNode,
                textEditingController: modelTextController,
                labelText: 'Model',
                hintText: 'Model',
                textInputType: TextInputType.text,
                textInputAction: TextInputAction.next,
                onFocusChange: (hasFocus) {},
                onChanged: (newText) {},
                padding: 0.0,
              ),

              AppFormField(
                focusNode: yearFocusNode,
                textEditingController: yearTextController,
                labelText: 'Year',
                hintText: 'Year',
                textInputType: TextInputType.text,
                textInputAction: TextInputAction.next,
                onFocusChange: (hasFocus) {},
                onChanged: (newText) {},
                padding: 0.0,
              ),

              AppFormField(
                focusNode: colorFocusNode,
                textEditingController: colorTextController,
                labelText: 'Color',
                hintText: 'Color',
                textInputType: TextInputType.text,
                textInputAction: TextInputAction.next,
                onFocusChange: (hasFocus) {},
                onChanged: (newText) {},
                padding: 0.0,
              ),

              //page 3
              const Text('Body type', style: AppTextStyles.zonaPro14),

              RadioGroup<BodyType>(
                groupValue: selectedBodyType,
                onChanged: (BodyType? value) {
                  setState(() {
                    selectedBodyType = value;
                  });
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
                groupValue: selectedFuelType,
                onChanged: (FuelType? value) {
                  setState(() {
                    selectedFuelType = value;
                  });
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
                groupValue: selectedTransmissionType,
                onChanged: (TransmissionType? value) {
                  setState(() {
                    selectedTransmissionType = value;
                  });
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
        ),
      ),
    );
  }
}
