import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_futter_project/common/app_colors.dart';
import 'package:test_futter_project/di/injection_container.dart';
import 'package:test_futter_project/presentation/bloc/authentication/authentication_cubit.dart';
import 'package:test_futter_project/presentation/bloc/details/details_page_cubit.dart';
import 'package:test_futter_project/presentation/bloc/home/explore_page/explore_page_cubit.dart';
import 'package:test_futter_project/presentation/bloc/home/home_bottom_bar/home_bottom_bar_cubit.dart';
import 'package:test_futter_project/presentation/bloc/home/inbox_page/inbox_page_cubit.dart';
import 'package:test_futter_project/presentation/bloc/search/search_page_cubit.dart';
import 'package:test_futter_project/presentation/bloc/user/user_data_cubit.dart';
import 'package:test_futter_project/utils/app_router.dart';
import 'package:test_futter_project/utils/l10n.dart';
import 'package:test_futter_project/utils/localisation_util.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initDependenciesContainer();

  //todo: added flavors, but had to revert, because they broke the Android project.
  // The working version did not create a separate app, but used one. And launched only from
  // the android folder, not from `flutter run`. Updating gradle files did not help
  AppLocalisations.localisations = await LocalisationUtil.loadLocalisations(
    'assets/mocks/localisation_mock_response_data_it.json',
  );

  await LocalisationUtil.saveLocalisations(AppLocalisations.localisations);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (isPopped, result) async {
        await SystemNavigator.pop();
      },
      child: MultiBlocProvider(
        providers: [
          BlocProvider<ExplorePageCubit>(
            create: (context) => serviceLocator<ExplorePageCubit>()..init(),
          ),
          BlocProvider<SearchPageCubit>(
            create: (context) => serviceLocator<SearchPageCubit>()..init(),
          ),
          BlocProvider<UserDataCubit>(create: (context) => serviceLocator<UserDataCubit>()..init()),
          BlocProvider<HomeBottomBarCubit>(
            create: (context) => serviceLocator<HomeBottomBarCubit>(),
          ),
          BlocProvider<DetailsPageCubit>(create: (context) => serviceLocator<DetailsPageCubit>()),
          BlocProvider<AuthenticationCubit>(
            create: (context) => serviceLocator<AuthenticationCubit>()..init(),
          ),
          BlocProvider<InboxPageCubit>(
            create: (context) => serviceLocator<InboxPageCubit>()..init(),
          ),
        ],
        child: MaterialApp.router(
          title: AppLocalisations.appName,
          theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: AppColors.mainThemeColor)),
          routerConfig: AppRouter.router,
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}
