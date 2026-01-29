import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:test_futter_project/common/app_colors.dart';
import 'package:test_futter_project/di/injection_container.dart';
import 'package:test_futter_project/presentation/bloc/home/home_page_cubit.dart';
import 'package:test_futter_project/presentation/pages/home/explore_page.dart';
import 'package:test_futter_project/presentation/pages/search/search_page.dart';
import 'package:test_futter_project/utils/l10n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependenciesContainer();
  runApp(const MyApp());
}

final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return ExplorePage(title: AppLocalisations.explorePageTitle);
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'search',
          builder: (BuildContext context, GoRouterState state) {
            return const SearchPage();
          },
        ),
      ],
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomePageCubit>(
      create: (context) => serviceLocator<HomePageCubit>()..init(),
      child: MaterialApp.router(
        title: AppLocalisations.appName,
        theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: AppColors.mainThemeColor)),
        routerConfig: _router,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
