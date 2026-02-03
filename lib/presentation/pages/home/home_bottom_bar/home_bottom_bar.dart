import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_futter_project/presentation/bloc/home/home_bottom_bar/home_bottom_bar_cubit.dart';
import 'package:test_futter_project/presentation/bloc/home/home_bottom_bar/home_bottom_bar_state.dart';
import 'package:test_futter_project/presentation/pages/home/home_bottom_bar/widgets/home_bottom_bar_item.dart';

import '../../../../common/app_dimensions.dart';
import '../../../../utils/l10n.dart';

class HomeBottomBar extends StatelessWidget {
  final void Function() onAddPressed;

  const HomeBottomBar({required this.onAddPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBottomBarCubit, HomeBottomBarState>(
      builder: (context, state) {
        return BottomAppBar(
          padding: EdgeInsets.zero,
          child: Material(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(AppDimensions.normalL),
                topRight: Radius.circular(AppDimensions.normalL),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(AppDimensions.normalXS),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //todo: add an indexed enum or class for bar items
                  const HomeBottomBarItem(index: 0, icon: Icons.home_outlined),
                  const HomeBottomBarItem(index: 1, icon: Icons.favorite_border),

                  IconButton(
                    style: ButtonStyle(
                      backgroundColor: const WidgetStatePropertyAll(Colors.black),
                      foregroundColor: const WidgetStatePropertyAll(Colors.white),
                      overlayColor: WidgetStatePropertyAll(Colors.white.withAlpha(60)),
                    ),
                    icon: const Icon(Icons.add, size: AppDimensions.bottomAppBarIconEnlargedSize),
                    onPressed: onAddPressed,
                    tooltip: AppLocalisations.addCarButtonTooltip,
                  ),

                  const HomeBottomBarItem(index: 2, icon: Icons.mail_outlined),
                  const HomeBottomBarItem(index: 3, icon: Icons.settings_outlined),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
