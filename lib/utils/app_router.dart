import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:test_futter_project/presentation/pages/account/sub_pages/clear_data/clear_user_data_page.dart';
import 'package:test_futter_project/presentation/pages/account/sub_pages/location_settings/location_settings_page.dart';
import 'package:test_futter_project/presentation/pages/account/sub_pages/my_items/my_items_page.dart';
import 'package:test_futter_project/presentation/pages/account/sub_pages/personal_details/personal_details_page.dart';
import 'package:test_futter_project/presentation/pages/account/sub_pages/recently_viewed/recently_viewed_page.dart';
import 'package:test_futter_project/presentation/pages/article/article_page.dart';
import 'package:test_futter_project/presentation/pages/details/details_page.dart';
import 'package:test_futter_project/presentation/pages/home/home_page.dart';
import 'package:test_futter_project/presentation/pages/home/new_item_page/new_item_page.dart';
import 'package:test_futter_project/presentation/pages/home/widgets/placeholder_page.dart';
import 'package:test_futter_project/presentation/pages/messages/messages_page.dart';

import '../common/app_routes.dart';
import '../common/enums/details_page_source.dart';
import '../presentation/pages/search/search_page.dart';

class AppRouter {
  static final GoRouter _router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: AppRoutes.home,
        pageBuilder: (context, state) {
          final fromSetup = (state.extra is Map && (state.extra as Map)['fromSetup'] == true);

          if (fromSetup) {
            return CustomTransitionPage(
              child: const HomePage(),
              //reversed animation when going from the setup page
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                const begin = Offset(1.0, 0.0);
                const end = Offset.zero;
                var tween = Tween(begin: begin, end: end);
                var offsetAnimation = animation.drive(tween);
                return SlideTransition(position: offsetAnimation, child: child);
              },
            );
          } else {
            return const CupertinoPage(child: HomePage());
          }
        },
        routes: <RouteBase>[
          GoRoute(
            path: AppRoutes.search,
            pageBuilder: (context, state) => const CupertinoPage(child: SearchPage()),
            routes: <RouteBase>[_detailsRoute],
          ),
          _detailsRoute,
          GoRoute(
            path: AppRoutes.newItem,
            pageBuilder: (context, state) {
              final listKey = state.extra as GlobalKey<AnimatedListState>;

              return CupertinoPage(child: NewItemPage(exploreListKey: listKey));
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
            routes: <RouteBase>[_detailsRoute],
          ),
          GoRoute(
            path: AppRoutes.recentlyViewed,
            pageBuilder: (context, state) {
              return const CupertinoPage(child: RecentlyViewedPage());
            },
            routes: <RouteBase>[_detailsRoute],
          ),
          GoRoute(
            path: AppRoutes.clearUserData,
            pageBuilder: (context, state) {
              return const CupertinoPage(child: ClearUserDataPage());
            },
          ),
          GoRoute(
            path: AppRoutes.forgotPassword,
            pageBuilder: (context, state) {
              return const CupertinoPage(child: PlaceholderPage());
            },
          ),
          _inboxRoute,
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

  static final _inboxRoute = GoRoute(
    path: AppRoutes.inbox,
    pageBuilder: (context, state) {
      final conversationId = state.extra as String? ?? '';

      return CupertinoPage(child: MessagesPage(conversationId: conversationId));
    },
  );

  static final _detailsRoute = GoRoute(
    path: AppRoutes.details,
    pageBuilder: (context, state) {
      final carId = state.extra as String? ?? '';
      return CupertinoPage(child: DetailsPage(carId: carId));
    },
    routes: [_inboxRoute],
  );

  static void goToDetails({required DetailsPageSource from, required String carId}) {
    _router.go(from.detailsPath, extra: carId);
  }
}
