import 'package:get_it/get_it.dart';
import 'package:test_flutter_project/common/constants/app_constants.dart';
import 'package:test_flutter_project/core/di/modules/env_module.dart';
import 'package:test_flutter_project/core/di/modules/infrastructure_module.dart';
import 'package:test_flutter_project/core/di/modules/network_module.dart';
import 'package:test_flutter_project/core/di/modules/storage_module.dart';
import 'package:test_flutter_project/presentation/features/account/account_module.dart';
import 'package:test_flutter_project/presentation/features/article/article_module.dart';
import 'package:test_flutter_project/presentation/features/authentication/authentication_module.dart';
import 'package:test_flutter_project/presentation/features/color_picker/color_picker_module.dart';
import 'package:test_flutter_project/presentation/features/details/details_module.dart';
import 'package:test_flutter_project/presentation/features/explore/explore_module.dart';
import 'package:test_flutter_project/presentation/features/home_bottom_bar/home_bottom_bar_module.dart';
import 'package:test_flutter_project/presentation/features/inbox/inbox_module.dart';
import 'package:test_flutter_project/presentation/features/l10n/l10n_module.dart';
import 'package:test_flutter_project/presentation/features/location_settings/location_settings_module.dart';
import 'package:test_flutter_project/presentation/features/messages/messages_module.dart';
import 'package:test_flutter_project/presentation/features/new_item/new_item_module.dart';
import 'package:test_flutter_project/presentation/features/search/search_module.dart';
import 'package:test_flutter_project/presentation/features/share/share_module.dart';
import 'package:test_flutter_project/presentation/features/user/user_module.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependenciesContainer() async {
  serviceLocator.debugEventsEnabled = AppConstants.shouldShowGetItLogs;

  await registerStorageModule(serviceLocator);
  registerNetworkModule(serviceLocator);
  await registerEnvModule(serviceLocator);
  registerInfrastructureModule(serviceLocator);

  registerMessagesModule(serviceLocator);
  registerUserModule(serviceLocator);
  registerLocationSettingsModule(serviceLocator);
  registerL10nModule(serviceLocator);
  await registerAuthenticationModule(serviceLocator);
  registerInboxModule(serviceLocator);
  registerHomeBottomBarModule(serviceLocator);
  registerExploreModule(serviceLocator);
  registerArticleModule(serviceLocator);
  registerDetailsModule(serviceLocator);
  registerColorPickerModule(serviceLocator);
  registerNewItemModule(serviceLocator);
  registerSearchModule(serviceLocator);
  registerShareModule(serviceLocator);
  registerAccountModule(serviceLocator);
}
