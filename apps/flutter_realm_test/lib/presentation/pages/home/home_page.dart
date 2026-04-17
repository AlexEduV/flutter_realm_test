import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:test_flutter_project/common/constants/app_constants.dart';
import 'package:test_flutter_project/domain/usecases/permissions/check_location_permission_status_use_case.dart';
import 'package:test_flutter_project/presentation/bloc/home/home_bottom_bar/home_bottom_bar_cubit.dart';
import 'package:test_flutter_project/presentation/bloc/home/home_bottom_bar/home_bottom_bar_state.dart';
import 'package:test_flutter_project/presentation/pages/account/account_page.dart';
import 'package:test_flutter_project/presentation/pages/home/explore_page/explore_page.dart';
import 'package:test_flutter_project/presentation/pages/home/favorites_page/favorites_page.dart';
import 'package:test_flutter_project/presentation/pages/home/inbox_page/inbox_page.dart';

import '../../../common/constants/app_colors.dart';
import '../../../common/constants/app_routes.dart';
import '../../../core/di/injection_container.dart';
import '../../bloc/user/user_data_cubit.dart';
import 'home_bottom_bar/home_bottom_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  final PageController _pageController = PageController();
  int _bottomBarIndexDiff = 0;

  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final status = await serviceLocator<CheckLocationPermissionStatusUseCase>().call();

      if (!mounted) return;
      context.read<UserDataCubit>().updateLocationPermissionStatus(status.isGranted);

      final hasToAskPermission =
          status != PermissionStatus.granted &&
          status != PermissionStatus.permanentlyDenied &&
          status != PermissionStatus.denied;
      if (!hasToAskPermission) return;

      await context.read<UserDataCubit>().requestLocationPermission();
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: AppColors.scaffoldColor,
      body: BlocListener<HomeBottomBarCubit, HomeBottomBarState>(
        listenWhen: (previous, current) {
          _bottomBarIndexDiff = (current.currentSelectedTabIndex - previous.currentSelectedTabIndex)
              .abs();

          return previous.currentSelectedTabIndex != current.currentSelectedTabIndex;
        },
        listener: (context, state) {
          _pageController.animateToPage(
            state.currentSelectedTabIndex,
            duration: Duration(milliseconds: 300 * _bottomBarIndexDiff),
            curve: Curves.easeInOut,
          );
        },
        child: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            ExplorePage(scrollController: scrollController),
            const FavoritesPage(),
            const InboxPage(),
            const AccountPage(),
          ],
        ),
      ),
      bottomNavigationBar: HomeBottomBar(onAddPressed: _addCarToBase),
    );
  }

  void _addCarToBase() {
    final userDataCubit = context.read<UserDataCubit>();
    final isUserAuthenticated = userDataCubit.state.isUserAuthenticated;

    if (!isUserAuthenticated) {
      context.read<HomeBottomBarCubit>().updateSelectedIndex(AppConstants.homeTabAccount);
      return;
    }

    context.go(AppRoutes.home + AppRoutes.newItem);
    return;
  }
}
