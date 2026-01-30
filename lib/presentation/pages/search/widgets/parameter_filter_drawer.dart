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
        return Drawer(
          child: ListView(
            children: [
              DrawerHeader(
                child: Text(
                  AppLocalisations.searchFilterParametersTitle,
                  style: AppTextStyles.zonaPro20,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
