import 'package:mockito/annotations.dart';
import 'package:test_flutter_project/domain/data_sources/local/app_local_storage.dart';
import 'package:test_flutter_project/domain/data_sources/remote/owners_remote_data_source.dart';
import 'package:test_flutter_project/domain/data_sources/remote/users_remote_data_source.dart';
import 'package:test_flutter_project/domain/repositories/auth_repository.dart';
import 'package:test_flutter_project/domain/repositories/car_repository.dart';
import 'package:test_flutter_project/domain/repositories/user_repository.dart';
import 'package:test_flutter_project/domain/services/logging_service.dart';
import 'package:test_flutter_project/domain/services/time_service.dart';
import 'package:test_flutter_project/presentation/features/l10n/app_localisations_cubit.dart';
import 'package:test_flutter_project/presentation/features/user/user_data_cubit.dart';

//Note: all mockSpecs which are used in 3 or more files should be added here
@GenerateNiceMocks([
  MockSpec<LoggingService>(),
  MockSpec<TimeService>(),
  MockSpec<OwnersRemoteDataSource>(),
  MockSpec<UsersRemoteDataSource>(),
  MockSpec<AppLocalStorage>(),
  MockSpec<CarRepository>(),
  MockSpec<UserRepository>(),
  MockSpec<AuthRepository>(),
  MockSpec<UserDataCubit>(),
  MockSpec<AppLocalisationsCubit>(),
])
void main() {}
