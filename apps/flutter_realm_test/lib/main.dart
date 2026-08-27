import 'package:core_ui/core_ui.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:test_flutter_project/common/constants/app_constants.dart';
import 'package:test_flutter_project/common/extensions/context_extension.dart';
import 'package:test_flutter_project/core/di/injection_container.dart';
import 'package:test_flutter_project/core/router/app_router.dart';
import 'package:test_flutter_project/domain/usecases/regions/fetch_regions_use_case.dart';
import 'package:test_flutter_project/domain/usecases/regions/init_region_models_use_case.dart';
import 'package:test_flutter_project/presentation/features/article/article_page_cubit.dart';
import 'package:test_flutter_project/presentation/features/authentication/authentication_cubit.dart';
import 'package:test_flutter_project/presentation/features/color_picker/color_picker_cubit.dart';
import 'package:test_flutter_project/presentation/features/details/details_page_cubit.dart';
import 'package:test_flutter_project/presentation/features/explore/explore_page_cubit.dart';
import 'package:test_flutter_project/presentation/features/home_bottom_bar/home_bottom_bar_cubit.dart';
import 'package:test_flutter_project/presentation/features/inbox/inbox_page_cubit.dart';
import 'package:test_flutter_project/presentation/features/l10n/app_localisations_cubit.dart';
import 'package:test_flutter_project/presentation/features/l10n/l10n_keys.dart';
import 'package:test_flutter_project/presentation/features/location_settings/location_settings_page_cubit.dart';
import 'package:test_flutter_project/presentation/features/messages/messages_page_cubit.dart';
import 'package:test_flutter_project/presentation/features/new_item/new_item_page_cubit.dart';
import 'package:test_flutter_project/presentation/features/search/search_page_cubit.dart';
import 'package:test_flutter_project/presentation/features/share/share_cubit.dart';
import 'package:test_flutter_project/presentation/features/user/user_data_cubit.dart';
import 'package:test_flutter_project/presentation/widgets/dialogs/edit_dialog_cubit.dart';
import 'package:test_flutter_project/utils/dialog_helper.dart';
import 'package:test_flutter_project/utils/image_cache_util.dart';

void main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  if (!kIsWeb) {
    FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  }

  try {
    await initDependenciesContainer();

    //todo: added flavors, but had to revert, because they broke the Android project.
    // The working version did not create a separate app, but used one. And launched only from
    // the android folder, not from `flutter run`. Updating gradle files did not help

    await Future.wait([
      serviceLocator<InitRegionModelsUseCase>().call(),
      serviceLocator<FetchRegionsUseCase>().call(),
    ]);

    ImageCacheUtil.initExtendedCacheSize();
  } finally {
    FlutterNativeSplash.remove();
  }

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late AppLifecycleListener _listener;

  @override
  void initState() {
    super.initState();

    _listener = AppLifecycleListener(
      onResume: () {
        final ctx = AppRouter.router.routerDelegate.navigatorKey.currentContext;
        if (ctx != null) _handleLocationPermission(ctx);
      },
      onDetach: () async {
        await serviceLocator.reset();
      },
    );
    _scheduleInitialPermissionCheck();
  }

  @override
  void dispose() {
    _listener.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ExplorePageCubit>(
          create: (context) => serviceLocator<ExplorePageCubit>()..init(),
        ),
        BlocProvider<SearchPageCubit>(
          create: (context) => serviceLocator<SearchPageCubit>()..init(),
        ),
        BlocProvider<UserDataCubit>(create: (context) => serviceLocator<UserDataCubit>()..init()),
        BlocProvider<HomeBottomBarCubit>(create: (context) => serviceLocator<HomeBottomBarCubit>()),
        BlocProvider<DetailsPageCubit>(create: (context) => serviceLocator<DetailsPageCubit>()),
        BlocProvider<AuthenticationCubit>(
          create: (context) => serviceLocator<AuthenticationCubit>()..init(),
        ),
        BlocProvider<InboxPageCubit>(create: (context) => serviceLocator<InboxPageCubit>()..init()),
        BlocProvider<ArticlePageCubit>(create: (context) => serviceLocator<ArticlePageCubit>()),
        BlocProvider<AppLocalisationsCubit>(
          create: (context) => serviceLocator<AppLocalisationsCubit>(),
        ),
        BlocProvider<ShareCubit>(create: (context) => serviceLocator<ShareCubit>()),
        BlocProvider<EditDialogCubit>(create: (context) => serviceLocator<EditDialogCubit>()),
        BlocProvider<ColorPickerCubit>(create: (context) => serviceLocator<ColorPickerCubit>()),
        BlocProvider<MessagesPageCubit>(create: (context) => serviceLocator<MessagesPageCubit>()),
        BlocProvider<NewItemPageCubit>(
          create: (context) => serviceLocator<NewItemPageCubit>()..init(),
        ),
        BlocProvider<LocationSettingsPageCubit>(
          create: (context) => serviceLocator<LocationSettingsPageCubit>(),
        ),
      ],
      child: MaterialApp.router(
        title: serviceLocator<AppLocalisationsCubit>().getLocalisationByKey(L10nKeys.appName),
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.mainThemeColor),
          fontFamily: 'Zona Pro',
          radioTheme: const RadioThemeData(
            fillColor: WidgetStatePropertyAll(AppColors.headerColor),
          ),
          drawerTheme: const DrawerThemeData(backgroundColor: AppColors.scaffoldColor),
        ),
        routerConfig: AppRouter.router,
        debugShowCheckedModeBanner: false,
        showSemanticsDebugger: AppConstants.showSemantics,
      ),
    );
  }

  void _scheduleInitialPermissionCheck() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final context = AppRouter.router.routerDelegate.navigatorKey.currentContext;

      if (context != null) {
        _handleLocationPermission(context);
      } else {
        _scheduleInitialPermissionCheck();
      }
    });
  }

  Future<void> _handleLocationPermission(BuildContext context) async {
    final userDataCubit = context.read<UserDataCubit>();
    if (userDataCubit.state.isLoading) {
      await userDataCubit.stream.firstWhere((s) => !s.isLoading);
    }

    if (!context.mounted) return;

    final storedPermission = userDataCubit.state.user.isLocationPermissionGranted;

    if (storedPermission == null) {
      // First launch: never asked — show the native OS dialog
      await context.read<UserDataCubit>().requestLocationPermission();
      return;
    }

    final isGranted = await context.read<UserDataCubit>().isLocationPermissionGranted();

    if (!context.mounted) return;
    context.read<UserDataCubit>().updateLocationPermissionStatus(isGranted);

    if (isGranted) {
      if (!context.mounted) return;
      DialogHelper.dismissLocationPermissionDialog(context);
    } else {
      if (!context.mounted) return;

      await DialogHelper.showLocationPermissionDialog(
        context,
        title: context.trRead(L10nKeys.locationPermissionDialogTitle),
        description: context.trRead(L10nKeys.locationPermissionDialogDescription),
        confirmButtonTitle: context.trRead(L10nKeys.locationPermissionDialogOpenSettings),
        onConfirm: () => context.read<UserDataCubit>().openLocationSettings(),
      );
    }
  }
}
