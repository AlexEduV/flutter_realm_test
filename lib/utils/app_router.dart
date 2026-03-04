import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:test_futter_project/presentation/pages/account/sub_pages/location_settings/location_settings_page.dart';
import 'package:test_futter_project/presentation/pages/account/sub_pages/my_items/my_items_page.dart';
import 'package:test_futter_project/presentation/pages/account/sub_pages/personal_details/personal_details_page.dart';
import 'package:test_futter_project/presentation/pages/article/article_page.dart';
import 'package:test_futter_project/presentation/pages/details/details_page.dart';
import 'package:test_futter_project/presentation/pages/home/home_page.dart';
import 'package:test_futter_project/presentation/pages/home/widgets/placeholder_page.dart';

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
            routes: <RouteBase>[
              GoRoute(
                path: AppRoutes.details,
                pageBuilder: (context, state) {
                  final carId = state.extra as String? ?? '';
                  return CupertinoPage(child: DetailsPage(carId: carId));
                },
              ),
            ],
          ),
          GoRoute(
            path: AppRoutes.details,
            pageBuilder: (context, state) {
              final carId = state.extra as String? ?? '';
              return CupertinoPage(child: DetailsPage(carId: carId));
            },
          ),
          GoRoute(
            path: AppRoutes.personalDetails,
            pageBuilder: (context, state) {
              return const CupertinoPage(child: PersonalDetailsPage());
            },
          ),
          GoRoute(
            path: AppRoutes.locationSettings,
            pageBuilder: (context, state) {
              return const CupertinoPage(child: LocationSettingsPage());
            },
          ),
          GoRoute(
            path: AppRoutes.myItems,
            pageBuilder: (context, state) {
              return const CupertinoPage(child: MyItemsPage());
            },
          ),
          GoRoute(
            path: AppRoutes.forgotPassword,
            pageBuilder: (context, state) {
              return const CupertinoPage(child: PlaceholderPage());
            },
          ),
          GoRoute(
            path: AppRoutes.inbox,
            pageBuilder: (context, state) {
              //todo: pass the id to the next page
              //final ownerId = state.extra as String? ?? '';

              return const CupertinoPage(child: PlaceholderPage());
            },
          ),
          GoRoute(
            path: AppRoutes.articleDetails,
            pageBuilder: (context, state) {
              final articleId = state.extra as String? ?? '';

              return CupertinoPage(child: ArticlePage(articleId: articleId));
            },
          ),
        ],
      ),
    ],
  );

  static GoRouter get router => _router;

  static void goToDetailsRouteFromExplore(String carId) {
    _router.go('${AppRoutes.home}${AppRoutes.details}', extra: carId);
  }

  static void goToDetailsRouteFromSearch(String carId) {
    _router.go('${AppRoutes.home}${AppRoutes.search}/${AppRoutes.details}', extra: carId);
  }
}
