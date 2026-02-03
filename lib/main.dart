import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_futter_project/common/app_colors.dart';
import 'package:test_futter_project/di/injection_container.dart';
import 'package:test_futter_project/presentation/bloc/home/explore_page/explore_page_cubit.dart';
import 'package:test_futter_project/presentation/bloc/home/home_bottom_bar/home_bottom_bar_cubit.dart';
import 'package:test_futter_project/presentation/bloc/search/search_page_cubit.dart';
import 'package:test_futter_project/presentation/bloc/user/user_data_cubit.dart';
import 'package:test_futter_project/utils/app_router.dart';
import 'package:test_futter_project/utils/l10n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependenciesContainer();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ExplorePageCubit>(
          create: (context) => serviceLocator<ExplorePageCubit>()..init(),
        ),
        BlocProvider<SearchPageCubit>(
          create: (context) => serviceLocator<SearchPageCubit>()..loadData(),
        ),
        BlocProvider<UserDataCubit>(create: (context) => serviceLocator<UserDataCubit>()..init()),
        BlocProvider<HomeBottomBarCubit>(create: (context) => serviceLocator<HomeBottomBarCubit>()),
      ],
      child: MaterialApp.router(
        title: AppLocalisations.appName,
        theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: AppColors.mainThemeColor)),
        routerConfig: AppRouter.router,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
