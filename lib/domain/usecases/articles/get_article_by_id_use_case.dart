import 'package:test_futter_project/domain/entities/article_entity.dart';
import 'package:test_futter_project/domain/repositories/article_repository.dart';
import 'package:test_futter_project/domain/usecases/usecase.dart';

class GetArticleByIdUseCase extends UseCaseWithParams<String, Future<ArticleEntity>> {
  final ArticleRepository _articleRepository;

  GetArticleByIdUseCase(this._articleRepository);

  @override
  Future<ArticleEntity> call(String id) {
    return _articleRepository.getArticleById(id);
  }
}
