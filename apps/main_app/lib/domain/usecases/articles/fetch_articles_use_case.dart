import 'package:test_futter_project/domain/entities/article_entity.dart';
import 'package:test_futter_project/domain/repositories/article_repository.dart';
import 'package:test_futter_project/domain/usecases/usecase.dart';

class FetchArticlesUseCase extends UseCaseNoParams<Future<List<ArticleEntity>>> {
  final ArticleRepository _articleRepository;

  FetchArticlesUseCase(this._articleRepository);

  @override
  Future<List<ArticleEntity>> call() {
    return _articleRepository.fetchArticles();
  }
}
