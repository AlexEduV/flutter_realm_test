import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_futter_project/common/app_constants.dart';
import 'package:test_futter_project/presentation/bloc/home/home_bottom_bar/home_bottom_bar_cubit.dart';
import 'package:test_futter_project/presentation/bloc/home/home_bottom_bar/home_bottom_bar_state.dart';
import 'package:test_futter_project/presentation/pages/home/explore_page/explore_page.dart';
import 'package:test_futter_project/presentation/pages/home/widgets/dummy_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBottomBarCubit, HomeBottomBarState>(
      buildWhen: (previous, current) {
        return previous.currentSelectedTabIndex != current.currentSelectedTabIndex;
      },
      builder: (context, state) {
        switch (state.currentSelectedTabIndex) {
          case AppConstants.homeTabExplore:
            return const ExplorePage();
          default:
            return const DummyPage();
        }
      },
    );
  }
}
