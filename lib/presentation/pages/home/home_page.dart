import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:test_futter_project/common/app_constants.dart';
import 'package:test_futter_project/common/enums/body_type.dart';
import 'package:test_futter_project/common/enums/car_type.dart';
import 'package:test_futter_project/common/enums/fuel_type.dart';
import 'package:test_futter_project/common/enums/transmission_type.dart';
import 'package:test_futter_project/domain/entities/owner_entity.dart';
import 'package:test_futter_project/domain/usecases/database/add_car_use_case.dart';
import 'package:test_futter_project/domain/usecases/database/get_all_cars_use_case.dart';
import 'package:test_futter_project/domain/usecases/database/get_current_max_car_id_use_case.dart';
import 'package:test_futter_project/domain/usecases/permissions/check_location_permission_status_use_case.dart';
import 'package:test_futter_project/presentation/bloc/home/home_bottom_bar/home_bottom_bar_cubit.dart';
import 'package:test_futter_project/presentation/bloc/home/home_bottom_bar/home_bottom_bar_state.dart';
import 'package:test_futter_project/presentation/pages/account/account_page.dart';
import 'package:test_futter_project/presentation/pages/home/explore_page/explore_page.dart';
import 'package:test_futter_project/presentation/pages/home/favorites_page/favorites_page.dart';
import 'package:test_futter_project/presentation/pages/home/inbox_page/inbox_page.dart';

import '../../../common/app_colors.dart';
import '../../../di/injection_container.dart';
import '../../../domain/entities/car_entity.dart';
import '../../bloc/home/explore_page/explore_page_cubit.dart';
import '../../bloc/user/user_data_cubit.dart';
import 'home_bottom_bar/home_bottom_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  final GlobalKey<AnimatedListState> exploreListKey = GlobalKey<AnimatedListState>();
  final PageController _pageController = PageController();
  int _bottomBarIndexDiff = 0;

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
            ExplorePage(listKey: exploreListKey),
            const FavoritesPage(),
            const InboxPage(),
            const AccountPage(),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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

    final currentMaxCarId = serviceLocator<GetCurrentMaxCarIdUseCase>().call();
    final newCarId = (currentMaxCarId + 1).toString();

    userDataCubit.addCarIdToCreated(newCarId);

    //todo: need a new form page to input the data manually
    serviceLocator<AddCarUseCase>().call(
      CarEntity(
        carId: newCarId,
        model: 'Model Y',
        manufacturer: 'Tesla',
        isVerified: false,
        type: CarType.car.name,
        bodyType: BodyType.sedan.name,
        fuelType: FuelType.ev.name,
        transmissionType: TransmissionType.automatic.name,
        color: 'White',
        owner: OwnerEntity.fromUser(userDataCubit.user),
      ),
    );

    final cars = serviceLocator<GetAllCarsUseCase>().call();

    exploreListKey.currentState?.insertItem(cars.length - 1);
    context.read<ExplorePageCubit>().updateCars(cars);
  }
}
