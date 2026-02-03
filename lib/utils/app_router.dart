import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:test_futter_project/presentation/pages/home/home_page.dart';

import '../common/app_routes.dart';
import '../presentation/pages/search/search_page.dart';

class AppRouter {
  static final GoRouter _router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: AppRoutes.home,
        pageBuilder: (context, state) => const CupertinoPage(child: HomePage()),
        routes: <RouteBase>[
          GoRoute(
            path: AppRoutes.search,
            pageBuilder: (context, state) => const CupertinoPage(child: SearchPage()),
          ),
        ],
      ),
    ],
  );

  static GoRouter get router => _router;
}
