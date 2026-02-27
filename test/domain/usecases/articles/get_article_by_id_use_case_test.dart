import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:test_futter_project/domain/entities/article_entity.dart';
import 'package:test_futter_project/domain/usecases/articles/get_article_by_id_use_case.dart';

import 'fetch_articles_use_case_test.mocks.dart';

void main() {
  late MockArticleRepository mockRepository;
  late GetArticleByIdUseCase useCase;

  setUp(() {
    mockRepository = MockArticleRepository();
    useCase = GetArticleByIdUseCase(mockRepository);
  });

  test('should return article for given id from repository', () async {
    // Arrange
    const articleId = '123';
    final article = const ArticleEntity(
      id: articleId,
      title: 'Test Article',
      imageUrl: '',
      summary: '',
      paragraphs: [],
    );
    when(mockRepository.getArticleById(articleId)).thenAnswer((_) async => article);

    // Act
    final result = await useCase.call(articleId);

    // Assert
    expect(result, article);
    verify(mockRepository.getArticleById(articleId)).called(1);
    verifyNoMoreInteractions(mockRepository);
  });

  test('should propagate exceptions from repository', () {
    // Arrange
    const articleId = 'not_found';
    when(mockRepository.getArticleById(articleId)).thenThrow(Exception('Not found'));

    // Act & Assert
    expect(() => useCase.call(articleId), throwsA(isA<Exception>()));
    verify(mockRepository.getArticleById(articleId)).called(1);
    verifyNoMoreInteractions(mockRepository);
  });
}
