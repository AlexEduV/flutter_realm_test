import 'package:test_flutter_project/domain/data_sources/remote/article_remote_data_source.dart';
import 'package:test_flutter_project/domain/entities/article_entity.dart';
import 'package:test_flutter_project/domain/repositories/article_repository.dart';

class ArticleRepositoryImpl implements ArticleRepository {
  final ArticleRemoteDataSource _articleRemoteDataSource;

  ArticleRepositoryImpl(this._articleRemoteDataSource);

  List<ArticleEntity> articles = [];

  @override
  Future<List<ArticleEntity>> fetchArticles() {
    return _articleRemoteDataSource.fetchArticles();
  }

  @override
  Future<ArticleEntity> getArticleById(String id) {
    return _articleRemoteDataSource.getArticleById(id);
  }
}
