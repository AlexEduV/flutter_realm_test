import 'package:test_futter_project/di/injection_container.dart';
import 'package:test_futter_project/domain/data_sources/local/base_local_storage.dart';
import 'package:test_futter_project/domain/models/auth_result.dart';
import 'package:test_futter_project/domain/repositories/auth_repository.dart';
import 'package:test_futter_project/domain/usecases/owners/fetch_owners_use_case.dart';
import 'package:test_futter_project/domain/usecases/users/get_max_user_id_use_case.dart';
import 'package:test_futter_project/domain/usecases/users/load_users_use_case.dart';
import 'package:test_futter_project/domain/usecases/users/save_users_use_case.dart';
import 'package:test_futter_project/l10n/l10n_keys.dart';
import 'package:test_futter_project/presentation/bloc/l10n/app_localisations_cubit.dart';
import 'package:test_futter_project/utils/auth_session_util.dart';

import '../../common/extensions/user_scheme_extension.dart';
import '../../domain/entities/user_entity.dart';
import '../data_sources/remote/mock_users_remote_data_source_impl.dart';

class AuthRepositoryImpl implements AuthRepository {
  final BaseLocalStorage _localStorage;
  final FetchOwnersUseCase _fetchOwnersUseCase;

  AuthRepositoryImpl(this._localStorage, this._fetchOwnersUseCase);

  late final List<UserEntity> users;
  late bool isAuthenticated = false;

  @override
  Future<void> init() async {
    await serviceLocator<LoadUsersUseCase>().call();
    await _fetchOwnersUseCase.call();

    users = serviceLocator<MockUsersRemoteDataSourceImpl>().initialUsers;
  }

  @override
  Future<void> logOut() async {
    await AuthSessionUtil.clearUserSession();
    _localStorage.clearUser();
    await Future.delayed(const Duration(milliseconds: 200));

    _localStorage.initUser();
    isAuthenticated = false;
  }

  @override
  Future<AuthResult> login({required String email, required String password}) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 1500));

    if (!users.any((element) => element.email == email)) {
      return AuthResult(
        success: false,
        message: serviceLocator<AppLocalisationsCubit>().getLocalisationByKey(
          L10nKeys.authErrorUserNotFoundMessage,
        ),
      );
    }

    if (!users.any((element) => element.password == password && element.email == email)) {
      return AuthResult(
        success: false,
        message: serviceLocator<AppLocalisationsCubit>().getLocalisationByKey(
          L10nKeys.authErrorIncorrectPassword,
        ),
      );
    }

    final user = users.firstWhere((element) => element.email == email);

    await AuthSessionUtil.saveUserSession(user.userId);

    _localStorage.clearUser();
    _localStorage.update(UserExtensions.fromEntity(user));

    isAuthenticated = true;
    return AuthResult(success: true);
  }

  @override
  Future<AuthResult> register({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  }) async {
    await Future.delayed(const Duration(milliseconds: 1500));

    if (users.any((element) => element.email == email)) {
      return AuthResult(
        success: false,
        message: serviceLocator<AppLocalisationsCubit>().getLocalisationByKey(
          L10nKeys.authErrorUserAlreadyExists,
        ),
      );
    }

    final newUserId = serviceLocator<GetMaxUserIdUseCase>().call() + 1;
    final user = UserEntity.initial(
      userId: '$newUserId',
      email: email,
      password: password,
      firstName: firstName,
      lastName: lastName,
    );

    users.add(user);
    await serviceLocator<SaveUsersUseCase>().call(users);
    await AuthSessionUtil.saveUserSession(newUserId.toString());

    _localStorage.clearUser();
    _localStorage.update(UserExtensions.fromEntity(user));

    isAuthenticated = true;
    return AuthResult(success: true);
  }

  @override
  Future<void> deleteAccount(String email) async {
    await logOut();

    users.removeWhere((element) => element.email == email);
    await serviceLocator<SaveUsersUseCase>().call(users);
  }

  @override
  Future<void> updateUser(String email, UserEntity data) async {
    if (!isAuthenticated) return;

    users.removeWhere((element) => element.email == email);
    users.add(data);

    await serviceLocator<SaveUsersUseCase>().call(users);
  }
}
