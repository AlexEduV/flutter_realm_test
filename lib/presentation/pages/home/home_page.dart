import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_futter_project/common/app_constants.dart';
import 'package:test_futter_project/common/enums/body_type.dart';
import 'package:test_futter_project/common/enums/fuel_type.dart';
import 'package:test_futter_project/common/enums/transmission_type.dart';
import 'package:test_futter_project/domain/usecases/database/add_car_use_case.dart';
import 'package:test_futter_project/domain/usecases/database/get_all_cars_use_case.dart';
import 'package:test_futter_project/domain/usecases/database/get_current_max_car_id_use_case.dart';
import 'package:test_futter_project/presentation/bloc/home/home_bottom_bar/home_bottom_bar_cubit.dart';
import 'package:test_futter_project/presentation/bloc/home/home_bottom_bar/home_bottom_bar_state.dart';
import 'package:test_futter_project/presentation/pages/home/explore_page/explore_page.dart';
import 'package:test_futter_project/presentation/pages/home/favorites_page/favorites_page.dart';
import 'package:test_futter_project/presentation/pages/home/widgets/placeholder_page.dart';

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

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
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
      body: BlocBuilder<HomeBottomBarCubit, HomeBottomBarState>(
        buildWhen: (previous, current) {
          return previous.currentSelectedTabIndex != current.currentSelectedTabIndex;
        },
        builder: (context, state) {
          //todo: when the pages will be ready, add animation for switching between them
          switch (state.currentSelectedTabIndex) {
            case AppConstants.homeTabExplore:
              return ExplorePage(listKey: exploreListKey);
            case AppConstants.homeTabFavorites:
              return const FavoritesPage();
            default:
              return const PlaceholderPage();
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: HomeBottomBar(onAddPressed: _addCarToBase),
    );
  }

  void _addCarToBase() {
    final currentMaxCarId = serviceLocator<GetCurrentMaxCarIdUseCase>().call();

    serviceLocator<AddCarUseCase>().call(
      CarEntity(
        carId: (currentMaxCarId + 1).toString(),
        model: 'Model Y',
        manufacturer: 'Tesla',
        isVerified: false,
        type: 'car',
        bodyType: BodyType.sedan.name,
        fuelType: FuelType.ev.name,
        transmissionType: TransmissionType.automatic.name,
        color: 'White',
      ),
    );

    final cars = serviceLocator<GetAllCarsUseCase>().call();

    exploreListKey.currentState?.insertItem(cars.length - 1);
    context.read<ExplorePageCubit>().updateCars(cars);
  }
}
