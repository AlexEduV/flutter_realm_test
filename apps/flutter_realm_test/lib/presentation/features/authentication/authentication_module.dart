import 'package:get_it/get_it.dart';
import 'package:test_flutter_project/domain/data_sources/remote/base_remote_storage.dart';

import '../../../data/repositories/auth_repository_impl.dart';
import '../../../domain/data_sources/local/base_local_storage.dart';
import '../../../domain/data_sources/remote/messages_remote_data_source.dart';
import '../../../domain/data_sources/remote/users_remote_data_source.dart';
import '../../../domain/repositories/auth_repository.dart';
import '../../../domain/repositories/owner_repository.dart';
import '../../../domain/usecases/authentication/delete_account_use_case.dart';
import '../../../domain/usecases/authentication/login_use_case.dart';
import '../../../domain/usecases/authentication/logout_use_case.dart';
import '../../../domain/usecases/authentication/register_use_case.dart';
import '../l10n/app_localisations_cubit.dart';
import '../user/user_data_cubit.dart';
import 'authentication_cubit.dart';

Future<void> registerAuthenticationModule(GetIt serviceLocator) async {
  final authRepositoryImpl = AuthRepositoryImpl(
    serviceLocator<BaseLocalStorage>(),
    serviceLocator<BaseRemoteStorage>(),
    serviceLocator<UsersRemoteDataSource>(),
    serviceLocator<MessagesRemoteDataSource>(),
    serviceLocator<OwnerRepository>(),
  );
  await authRepositoryImpl.init();
  serviceLocator.registerLazySingleton<AuthRepository>(() => authRepositoryImpl);

  serviceLocator.registerLazySingleton(() => LogoutUseCase(serviceLocator()));
  serviceLocator.registerLazySingleton(() => LoginUseCase(serviceLocator()));
  serviceLocator.registerLazySingleton(() => RegisterUseCase(serviceLocator()));
  serviceLocator.registerLazySingleton(() => DeleteAccountUseCase(serviceLocator()));

  serviceLocator.registerLazySingleton(
    () => AuthenticationCubit(
      serviceLocator<AppLocalisationsCubit>(),
      serviceLocator<UserDataCubit>(),
      serviceLocator<LoginUseCase>(),
      serviceLocator<LogoutUseCase>(),
      serviceLocator<RegisterUseCase>(),
      serviceLocator<DeleteAccountUseCase>(),
    ),
  );
}
