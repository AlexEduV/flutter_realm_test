import 'package:get_it/get_it.dart';

import '../../../data/data_sources/remote/seed_article_remote_data_source_impl.dart';
import '../../../data/repositories/article_repository_impl.dart';
import '../../../domain/data_sources/remote/article_remote_data_source.dart';
import '../../../domain/repositories/article_repository.dart';
import '../../../domain/usecases/articles/fetch_articles_use_case.dart';
import '../../../domain/usecases/articles/get_article_by_id_use_case.dart';
import 'article_page_cubit.dart';

void registerArticleModule(GetIt serviceLocator) {
  serviceLocator.registerLazySingleton<ArticleRemoteDataSource>(
    () => SeedArticleRemoteDataSourceImpl(serviceLocator()),
  );

  serviceLocator.registerLazySingleton<ArticleRepository>(
    () => ArticleRepositoryImpl(serviceLocator()),
  );

  serviceLocator.registerLazySingleton(() => FetchArticlesUseCase(serviceLocator()));
  serviceLocator.registerLazySingleton(() => GetArticleByIdUseCase(serviceLocator()));

  serviceLocator.registerFactory(() => ArticlePageCubit(serviceLocator()));
}
