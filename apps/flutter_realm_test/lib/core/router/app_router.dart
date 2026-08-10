import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:test_flutter_project/presentation/features/account/sub_pages/clear_data/clear_user_data_page.dart';
import 'package:test_flutter_project/presentation/features/account/sub_pages/my_items/my_items_page.dart';
import 'package:test_flutter_project/presentation/features/account/sub_pages/personal_details/personal_details_page.dart';
import 'package:test_flutter_project/presentation/features/account/sub_pages/recently_viewed/recently_viewed_page.dart';
import 'package:test_flutter_project/presentation/features/article/article_page.dart';
import 'package:test_flutter_project/presentation/features/article/article_page_params.dart';
import 'package:test_flutter_project/presentation/features/details/details_page.dart';
import 'package:test_flutter_project/presentation/features/details/details_page_params.dart';
import 'package:test_flutter_project/presentation/features/home/home_page.dart';
import 'package:test_flutter_project/presentation/features/home/home_page_params.dart';
import 'package:test_flutter_project/presentation/features/inbox/inbox_page_params.dart';
import 'package:test_flutter_project/presentation/features/location_settings/location_settings_page.dart';
import 'package:test_flutter_project/presentation/features/messages/messages_page.dart';
import 'package:test_flutter_project/presentation/features/new_item/new_item_page.dart';
import 'package:test_flutter_project/presentation/widgets/placeholder_page.dart';

import '../../common/constants/app_routes.dart';
import '../../common/enums/details_page_source.dart';
import '../../presentation/features/search/search_page.dart';

class AppRouter {
  static final GoRouter _router = GoRouter(
    initialLocation: AppRoutes.home,
    routes: <RouteBase>[
      GoRoute(
        path: AppRoutes.home,
        pageBuilder: (context, state) {
          final extra = state.extra;
          final isFromSetup = extra is HomePageParams ? extra.isFromSetup : false;

          if (isFromSetup) {
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
            routes: <RouteBase>[_buildDetailsRoute()],
          ),
          _buildDetailsRoute(),
          GoRoute(
            path: AppRoutes.newItem,
            pageBuilder: (context, state) {
              return const CupertinoPage(child: NewItemPage());
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
            routes: <RouteBase>[_buildDetailsRoute()],
          ),
          GoRoute(
            path: AppRoutes.recentlyViewed,
            pageBuilder: (context, state) {
              return const CupertinoPage(child: RecentlyViewedPage());
            },
            routes: <RouteBase>[_buildDetailsRoute()],
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
              final extra = state.extra;
              final articleId = extra is ArticlePageParams ? extra.articleId : '';

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
      final extra = state.extra;
      final conversationId = extra is InboxPageParams ? extra.conversationId : '';

      return CupertinoPage(child: MessagesPage(conversationId: conversationId));
    },
  );

  static GoRoute _buildDetailsRoute() => GoRoute(
    path: AppRoutes.details,
    pageBuilder: (context, state) {
      final extra = state.extra;
      final carId = extra is DetailsPageParams ? extra.carId : '';
      return CupertinoPage(child: DetailsPage(carId: carId));
    },
    routes: [_inboxRoute],
  );

  static void goToDetails({required DetailsPageSource from, required String carId}) {
    _router.go(from.detailsPath, extra: DetailsPageParams(carId: carId));
  }

  static void goToInbox({required BuildContext context, required String conversationId}) {
    context.go(
      AppRoutes.home + AppRoutes.inbox,
      extra: InboxPageParams(conversationId: conversationId),
    );
  }

  static void goToArticle({required BuildContext context, required String articleId}) {
    context.go(
      AppRoutes.home + AppRoutes.articleDetails,
      extra: ArticlePageParams(articleId: articleId),
    );
  }
}
