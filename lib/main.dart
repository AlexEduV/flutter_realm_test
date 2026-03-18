import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_futter_project/common/app_colors.dart';
import 'package:test_futter_project/di/injection_container.dart';
import 'package:test_futter_project/domain/data_sources/remote/region_remote_data_source.dart';
import 'package:test_futter_project/l10n/l10n_keys.dart';
import 'package:test_futter_project/presentation/bloc/account/edit_dialog_cubit.dart';
import 'package:test_futter_project/presentation/bloc/article/article_page_cubit.dart';
import 'package:test_futter_project/presentation/bloc/authentication/authentication_cubit.dart';
import 'package:test_futter_project/presentation/bloc/details/details_page_cubit.dart';
import 'package:test_futter_project/presentation/bloc/home/explore_page/explore_page_cubit.dart';
import 'package:test_futter_project/presentation/bloc/home/home_bottom_bar/home_bottom_bar_cubit.dart';
import 'package:test_futter_project/presentation/bloc/home/inbox_page/inbox_page_cubit.dart';
import 'package:test_futter_project/presentation/bloc/l10n/app_localisations_cubit.dart';
import 'package:test_futter_project/presentation/bloc/messages/messages_page_cubit.dart';
import 'package:test_futter_project/presentation/bloc/search/search_page_cubit.dart';
import 'package:test_futter_project/presentation/bloc/share/share_cubit.dart';
import 'package:test_futter_project/presentation/bloc/user/user_data_cubit.dart';
import 'package:test_futter_project/utils/app_router.dart';
import 'package:test_futter_project/utils/image_cache_util.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initDependenciesContainer();

  //todo: added flavors, but had to revert, because they broke the Android project.
  // The working version did not create a separate app, but used one. And launched only from
  // the android folder, not from `flutter run`. Updating gradle files did not help

  await serviceLocator<RegionRemoteDataSource>().init();

  ImageCacheUtil.initExtendedCacheSize();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;

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
          BlocProvider<ArticlePageCubit>(create: (context) => serviceLocator<ArticlePageCubit>()),
          BlocProvider<AppLocalisationsCubit>(
            create: (context) => serviceLocator<AppLocalisationsCubit>(),
          ),
          BlocProvider<ShareCubit>(create: (context) => serviceLocator<ShareCubit>()),
          BlocProvider<EditDialogCubit>(create: (context) => serviceLocator<EditDialogCubit>()),
          BlocProvider<MessagesPageCubit>(create: (context) => serviceLocator<MessagesPageCubit>()),
        ],
        child: MaterialApp.router(
          title: serviceLocator<AppLocalisationsCubit>().getLocalisationByKey(L10nKeys.appName),
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: AppColors.mainThemeColor),
            fontFamily: 'Zona Pro',
          ),
          routerConfig: AppRouter.router,
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}
