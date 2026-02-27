import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test_futter_project/domain/entities/article_entity.dart';
import 'package:test_futter_project/domain/repositories/article_repository.dart';
import 'package:test_futter_project/domain/usecases/articles/fetch_articles_use_case.dart';

import 'fetch_articles_use_case_test.mocks.dart';

@GenerateMocks([ArticleRepository])
void main() {
  late MockArticleRepository mockRepository;
  late FetchArticlesUseCase useCase;

  setUp(() {
    mockRepository = MockArticleRepository();
    useCase = FetchArticlesUseCase(mockRepository);
  });

  test('should fetch articles from repository', () async {
    // Arrange
    final articles = [
      const ArticleEntity(
        id: '1',
        title: 'Test Article 1',
        imageUrl: '',
        summary: '',
        paragraphs: [],
      ),
      const ArticleEntity(
        id: '2',
        title: 'Test Article 2',
        imageUrl: '',
        summary: '',
        paragraphs: [],
      ),
    ];
    when(mockRepository.fetchArticles()).thenAnswer((_) async => articles);

    // Act
    final result = await useCase.call();

    // Assert
    expect(result, articles);
    verify(mockRepository.fetchArticles()).called(1);
    verifyNoMoreInteractions(mockRepository);
  });

  test('should return empty list if repository returns empty', () async {
    // Arrange
    when(mockRepository.fetchArticles()).thenAnswer((_) async => []);

    // Act
    final result = await useCase.call();

    // Assert
    expect(result, []);
    verify(mockRepository.fetchArticles()).called(1);
    verifyNoMoreInteractions(mockRepository);
  });
}
