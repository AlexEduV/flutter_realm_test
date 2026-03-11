import '../app_routes.dart';

enum DetailsPageSource { explore, myItems, recentlyViewed, search }

extension DetailsPageSourcePath on DetailsPageSource {
  String get detailsPath {
    switch (this) {
      case DetailsPageSource.myItems:
        return '${AppRoutes.home}${AppRoutes.myItems}/${AppRoutes.details}';
      case DetailsPageSource.recentlyViewed:
        return '${AppRoutes.home}${AppRoutes.recentlyViewed}/${AppRoutes.details}';
      case DetailsPageSource.search:
        return '${AppRoutes.home}${AppRoutes.search}/${AppRoutes.details}';
      default:
        return '${AppRoutes.home}${AppRoutes.details}';
    }
  }
}
