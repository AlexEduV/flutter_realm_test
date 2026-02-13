import 'package:flutter_test/flutter_test.dart';
import 'package:test_futter_project/di/injection_container.dart';
import 'package:test_futter_project/domain/data_sources/auth_service.dart';
import 'package:test_futter_project/domain/data_sources/base_local_storage.dart';
import 'package:test_futter_project/domain/data_sources/car_api_service.dart';
import 'package:test_futter_project/domain/repositories/auth_repository.dart';
import 'package:test_futter_project/domain/repositories/car_repository.dart';
import 'package:test_futter_project/domain/repositories/permission_repository.dart';
import 'package:test_futter_project/domain/usecases/database/add_car_use_case.dart';
import 'package:test_futter_project/domain/usecases/database/delete_all_cars_use_case.dart';
import 'package:test_futter_project/domain/usecases/database/delete_car_by_id_use_case.dart';
import 'package:test_futter_project/domain/usecases/database/get_all_cars_use_case.dart';
import 'package:test_futter_project/domain/usecases/database/get_car_by_id_use_case.dart';
import 'package:test_futter_project/domain/usecases/database/get_current_max_car_id_use_case.dart';
import 'package:test_futter_project/domain/usecases/database/sync_cars_use_case.dart';
import 'package:test_futter_project/domain/usecases/database/watch_cars_use_case.dart';
import 'package:test_futter_project/domain/usecases/permissions/check_location_permission_status_use_case.dart';
import 'package:test_futter_project/domain/usecases/permissions/request_location_permission_use_case.dart';
import 'package:test_futter_project/presentation/bloc/authentication/authentication_cubit.dart';
import 'package:test_futter_project/presentation/bloc/details/details_page_cubit.dart';
import 'package:test_futter_project/presentation/bloc/home/explore_page/explore_page_cubit.dart';
import 'package:test_futter_project/presentation/bloc/home/home_bottom_bar/home_bottom_bar_cubit.dart';
import 'package:test_futter_project/presentation/bloc/search/search_page_cubit.dart';
import 'package:test_futter_project/presentation/bloc/user/user_data_cubit.dart';

void main() {
  setUpAll(() async {
    await initDependenciesContainer();
  });

  tearDown(() {
    serviceLocator.reset();
  });

  test('All dependencies are registered and resolvable', () {
    expect(serviceLocator.isRegistered<AuthService>(), isTrue);
    expect(serviceLocator.isRegistered<BaseLocalStorage>(), isTrue);
    expect(serviceLocator.isRegistered<CarApiService>(), isTrue);
    expect(serviceLocator.isRegistered<CarRepository>(), isTrue);
    expect(serviceLocator.isRegistered<PermissionRepository>(), isTrue);
    expect(serviceLocator.isRegistered<AuthRepository>(), isTrue);

    expect(serviceLocator.isRegistered<ExplorePageCubit>(), isTrue);
    expect(serviceLocator.isRegistered<SearchPageCubit>(), isTrue);
    expect(serviceLocator.isRegistered<UserDataCubit>(), isTrue);
    expect(serviceLocator.isRegistered<HomeBottomBarCubit>(), isTrue);
    expect(serviceLocator.isRegistered<DetailsPageCubit>(), isTrue);

    expect(serviceLocator.isRegistered<RequestLocationPermissionUseCase>(), isTrue);
    expect(serviceLocator.isRegistered<CheckLocationPermissionStatusUseCase>(), isTrue);
    expect(serviceLocator.isRegistered<WatchCarsUseCase>(), isTrue);
    expect(serviceLocator.isRegistered<SyncCarsUseCase>(), isTrue);
    expect(serviceLocator.isRegistered<AddCarUseCase>(), isTrue);
    expect(serviceLocator.isRegistered<GetAllCarsUseCase>(), isTrue);
    expect(serviceLocator.isRegistered<DeleteCarByIdUseCase>(), isTrue);
    expect(serviceLocator.isRegistered<DeleteAllCarsUseCase>(), isTrue);
    expect(serviceLocator.isRegistered<GetCarByIdUseCase>(), isTrue);
    expect(serviceLocator.isRegistered<GetCurrentMaxCarIdUseCase>(), isTrue);
    expect(serviceLocator.isRegistered<AuthenticationCubit>(), isTrue);
  });

  // test('All dependencies can be resolved', () {
  //   expect(serviceLocator<AuthService>(), isA<AuthService>());
  //   expect(serviceLocator<BaseLocalStorage>(), isA<BaseLocalStorage>());
  //   expect(serviceLocator<CarApiService>(), isA<CarApiService>());
  //   expect(serviceLocator<CarRepository>(), isA<CarRepository>());
  //   expect(serviceLocator<PermissionRepository>(), isA<PermissionRepository>());
  //   expect(serviceLocator<AuthRepository>(), isA<AuthRepository>());
  //
  //   expect(serviceLocator<ExplorePageCubit>(), isA<ExplorePageCubit>());
  //   expect(serviceLocator<SearchPageCubit>(), isA<SearchPageCubit>());
  //   expect(serviceLocator<UserDataCubit>(), isA<UserDataCubit>());
  //   expect(serviceLocator<HomeBottomBarCubit>(), isA<HomeBottomBarCubit>());
  //   expect(serviceLocator<DetailsPageCubit>(), isA<DetailsPageCubit>());
  //
  //   expect(
  //     serviceLocator<RequestLocationPermissionUseCase>(),
  //     isA<RequestLocationPermissionUseCase>(),
  //   );
  //   expect(
  //     serviceLocator<CheckLocationPermissionStatusUseCase>(),
  //     isA<CheckLocationPermissionStatusUseCase>(),
  //   );
  //   expect(serviceLocator<WatchCarsUseCase>(), isA<WatchCarsUseCase>());
  //   expect(serviceLocator<SyncCarsUseCase>(), isA<SyncCarsUseCase>());
  //   expect(serviceLocator<AddCarUseCase>(), isA<AddCarUseCase>());
  //   expect(serviceLocator<GetAllCarsUseCase>(), isA<GetAllCarsUseCase>());
  //   expect(serviceLocator<DeleteCarByIdUseCase>(), isA<DeleteCarByIdUseCase>());
  //   expect(serviceLocator<DeleteAllCarsUseCase>(), isA<DeleteAllCarsUseCase>());
  //   expect(serviceLocator<GetCarByIdUseCase>(), isA<GetCarByIdUseCase>());
  //   expect(serviceLocator<GetCurrentMaxCarIdUseCase>(), isA<GetCurrentMaxCarIdUseCase>());
  //   expect(serviceLocator<AuthenticationCubit>(), isA<AuthenticationCubit>());
  // });
  //
  // test('Singletons return the same instance', () {
  //   expect(identical(serviceLocator<AuthService>(), serviceLocator<AuthService>()), isTrue);
  //   expect(identical(serviceLocator<CarRepository>(), serviceLocator<CarRepository>()), isTrue);
  //   // ...repeat for other singletons as needed
  // });
  //
  // test('Factories return new instances', () {
  //   expect(serviceLocator<ExplorePageCubit>(), isNot(same(serviceLocator<ExplorePageCubit>())));
  //   expect(serviceLocator<SearchPageCubit>(), isNot(same(serviceLocator<SearchPageCubit>())));
  //   // ...repeat for other factories as needed
  // });
}
