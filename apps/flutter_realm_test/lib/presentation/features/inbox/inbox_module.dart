import 'package:get_it/get_it.dart';
import 'package:test_flutter_project/domain/services/time_service.dart';
import 'package:test_flutter_project/domain/usecases/inbox/get_unread_count_from_conversation_use_case.dart';

import '../../../data/repositories/inbox_repository_impl.dart';
import '../../../domain/repositories/inbox_repository.dart';
import '../../../domain/usecases/inbox/fetch_conversations_use_case.dart';
import '../../../domain/usecases/inbox/get_conversation_by_id_use_case.dart';
import '../../../domain/usecases/inbox/get_conversation_by_owner_id_use_case.dart';
import '../../../domain/usecases/inbox/save_conversations_use_case.dart';
import 'inbox_page_cubit.dart';

void registerInboxModule(GetIt serviceLocator) {
  serviceLocator.registerLazySingleton<InboxRepository>(
    () => InboxRepositoryImpl(serviceLocator()),
  );

  serviceLocator.registerLazySingleton(() => FetchConversationsUseCase(serviceLocator()));
  serviceLocator.registerLazySingleton(() => SaveConversationsUseCase(serviceLocator()));

  serviceLocator.registerLazySingleton(() => GetConversationByIdUseCase(serviceLocator()));
  serviceLocator.registerLazySingleton(() => GetConversationByOwnerIdUseCase(serviceLocator()));
  serviceLocator.registerLazySingleton(() => GetUnreadCountFromConversationUseCase());

  serviceLocator.registerLazySingleton(
    () => InboxPageCubit(
      serviceLocator<TimeService>(),
      serviceLocator<FetchConversationsUseCase>(),
      serviceLocator<SaveConversationsUseCase>(),
      serviceLocator<GetUnreadCountFromConversationUseCase>(),
    ),
  );
}
