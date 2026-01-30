import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_futter_project/common/app_text_styles.dart';
import 'package:test_futter_project/presentation/bloc/search/search_page_cubit.dart';
import 'package:test_futter_project/presentation/bloc/search/search_page_state.dart';
import 'package:test_futter_project/utils/l10n.dart';

class ParameterFilterDrawer extends StatelessWidget {
  const ParameterFilterDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchPageCubit, SearchPageState>(
      builder: (context, state) {
        final checkBoxPosition = ListTileControlAffinity.leading;

        return Drawer(
          child: ListView(
            children: [
              DrawerHeader(
                child: Text(
                  AppLocalisations.searchFilterParametersTitle,
                  style: AppTextStyles.zonaPro20,
                ),
              ),

              ListTile(
                title: Text(AppLocalisations.parameterYearName, style: AppTextStyles.zonaPro18),
              ),

              ListTile(
                title: Text(AppLocalisations.parameterBodyTypeName, style: AppTextStyles.zonaPro18),
              ),

              //todo: probably get the tile values using api mocks;
              CheckboxListTile(
                title: Text('Sedan'),
                value: false,
                onChanged: (bool? newValue) {},
                controlAffinity: checkBoxPosition,
              ),
              CheckboxListTile(
                title: Text('Hatchback'),
                value: false,
                onChanged: (bool? newValue) {},
                controlAffinity: checkBoxPosition,
              ),
              CheckboxListTile(
                title: Text('Universal'),
                value: false,
                onChanged: (bool? newValue) {},
                controlAffinity: checkBoxPosition,
              ),
              CheckboxListTile(
                title: Text('Minivan'),
                value: false,
                onChanged: (bool? newValue) {},
                controlAffinity: checkBoxPosition,
              ),
              CheckboxListTile(
                title: Text('Coupe'),
                value: false,
                onChanged: (bool? newValue) {},
                controlAffinity: checkBoxPosition,
              ),
              CheckboxListTile(
                title: Text('Cross-over'),
                value: false,
                onChanged: (bool? newValue) {},
                controlAffinity: checkBoxPosition,
              ),

              ListTile(
                title: Text(
                  AppLocalisations.parameterPriceRangeName,
                  style: AppTextStyles.zonaPro18,
                ),
              ),

              ListTile(
                title: Text(AppLocalisations.parameterFuelTypeName, style: AppTextStyles.zonaPro18),
              ),

              CheckboxListTile(
                title: Text('Diesel'),
                value: false,
                onChanged: (bool? newValue) {},
                controlAffinity: checkBoxPosition,
              ),
              CheckboxListTile(
                title: Text('Gasoline'),
                value: false,
                onChanged: (bool? newValue) {},
                controlAffinity: checkBoxPosition,
              ),
              CheckboxListTile(
                title: Text('EV'),
                value: false,
                onChanged: (bool? newValue) {},
                controlAffinity: checkBoxPosition,
              ),

              ListTile(
                title: Text(
                  AppLocalisations.parameterTransmissionTypeName,
                  style: AppTextStyles.zonaPro18,
                ),
              ),

              CheckboxListTile(
                title: Text('Manual'),
                value: false,
                onChanged: (bool? newValue) {},
                controlAffinity: checkBoxPosition,
              ),
              CheckboxListTile(
                title: Text('Automatic'),
                value: false,
                onChanged: (bool? newValue) {},
                controlAffinity: checkBoxPosition,
              ),
              CheckboxListTile(
                title: Text('Hybrid'),
                value: false,
                onChanged: (bool? newValue) {},
                controlAffinity: checkBoxPosition,
              ),
            ],
          ),
        );
      },
    );
  }
}
