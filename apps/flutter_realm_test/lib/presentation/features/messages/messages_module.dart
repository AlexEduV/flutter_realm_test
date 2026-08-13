import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';

import '../../../common/constants/api_constants.dart';
import '../../../data/data_sources/remote/gifs_remote_data_source_impl.dart';
import '../../../data/data_sources/remote/seed_messages_remote_data_source_impl.dart';
import '../../../data/repositories/file_picker_repository_impl.dart';
import '../../../data/repositories/gifs_repository_impl.dart';
import '../../../data/services/file_picker_service_impl.dart';
import '../../../domain/data_sources/remote/gifs_remote_data_source.dart';
import '../../../domain/data_sources/remote/messages_remote_data_source.dart';
import '../../../domain/models/env_params_model.dart';
import '../../../domain/repositories/file_picker_repository.dart';
import '../../../domain/repositories/gifs_repository.dart';
import '../../../domain/services/file_picker_service.dart';
import '../../../domain/usecases/env/get_env_data_by_key_use_case.dart';
import '../../../domain/usecases/file_picker/pick_attachment_file_use_case.dart';
import '../../../domain/usecases/gifs/get_trending_gifs_use_case.dart';
import '../../../domain/usecases/gifs/search_gifs_use_case.dart';
import '../../../domain/usecases/inbox/extract_users_from_conversation_use_case.dart';
import '../../../domain/usecases/inbox/get_conversation_by_id_use_case.dart';
import '../../../domain/usecases/owners/get_owner_by_id_use_case.dart';
import '../../../utils/date_formatter.dart';
import 'messages_page_cubit.dart';

void registerMessagesModule(GetIt serviceLocator) {
  String apiKey = '';
  try {
    apiKey = serviceLocator<GetEnvDataByKeyUseCase>().call(
      EnvParamsModel(key: ApiConstants.envKlipyKeyPath),
    );
  } catch (e) {
    debugPrint('Could not load API key: $e');
  }
  serviceLocator.registerLazySingleton<GifsRemoteDataSource>(
    () => GifsRemoteDataSourceImpl(serviceLocator(), apiKey),
  );

  serviceLocator.registerLazySingleton<MessagesRemoteDataSource>(
    () => SeedMessagesRemoteDataSourceImpl(serviceLocator()),
  );

  final filePicker = FilePickerIO();
  serviceLocator.registerLazySingleton<FilePickerService>(() => FilePickerServiceImpl(filePicker));

  serviceLocator.registerLazySingleton<FilePickerRepository>(
    () => FilePickerRepositoryImpl(serviceLocator()),
  );

  serviceLocator.registerLazySingleton<GifsRepository>(() => GifsRepositoryImpl(serviceLocator()));

  serviceLocator.registerLazySingleton(() => PickAttachmentFileUseCase(serviceLocator()));

  serviceLocator.registerLazySingleton(() => SearchGifsUseCase(serviceLocator()));
  serviceLocator.registerLazySingleton(() => GetTrendingGifsUseCase(serviceLocator()));

  serviceLocator.registerLazySingleton(() => ExtractUsersFromConversationUseCase(serviceLocator()));

  serviceLocator.registerFactory(
    () => MessagesPageCubit(
      serviceLocator<SearchGifsUseCase>(),
      serviceLocator<GetTrendingGifsUseCase>(),
      serviceLocator<PickAttachmentFileUseCase>(),
      serviceLocator<GetConversationByIdUseCase>(),
      serviceLocator<GetOwnerByIdUseCase>(),
      serviceLocator<ExtractUsersFromConversationUseCase>(),
      serviceLocator<DateFormatter>(),
    ),
  );
}
