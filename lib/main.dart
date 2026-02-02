import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:test_futter_project/common/app_colors.dart';
import 'package:test_futter_project/common/app_routes.dart';
import 'package:test_futter_project/di/injection_container.dart';
import 'package:test_futter_project/presentation/bloc/home/explore_page_cubit.dart';
import 'package:test_futter_project/presentation/bloc/search/search_page_cubit.dart';
import 'package:test_futter_project/presentation/pages/home/explore_page.dart';
import 'package:test_futter_project/presentation/pages/search/search_page.dart';
import 'package:test_futter_project/utils/l10n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependenciesContainer();
  runApp(const MyApp());
}

const _navigationTransitionDuration = Duration(milliseconds: 300);

Widget _navigationTransitionType(Animation<double> animation, Widget child) {
  return FadeTransition(opacity: animation, child: child);
}

final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: AppRoutes.home,
      pageBuilder: (context, state) => const CupertinoPage(child: ExplorePage()),
      routes: <RouteBase>[
        GoRoute(
          path: AppRoutes.search,
          pageBuilder: (context, state) => const CupertinoPage(child: SearchPage()),
        ),
      ],
    ),
  ],
);

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
      ],
      child: MaterialApp.router(
        title: AppLocalisations.appName,
        theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: AppColors.mainThemeColor)),
        routerConfig: _router,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
