import 'package:flutter_test/flutter_test.dart';
import 'package:test_futter_project/domain/entities/article_entity.dart';
import 'package:test_futter_project/domain/entities/author_entity.dart';

void main() {
  group('ArticleEntity', () {
    test('empty factory returns correct default values', () {
      final article = ArticleEntity.empty();
      expect(article.id, '');
      expect(article.title, '');
      expect(article.summary, '');
      expect(article.paragraphs, []);
      expect(article.author, const AuthorEntity(id: 'testId', fullName: 'Test Author'));
      expect(article.datePublished, '20/11/2022');
      expect(article.minsToRead, isNull);
      expect(article.imageUrl, isNull);
      expect(article.isHovering, isFalse);
    });

    test('fromJson creates correct ArticleEntity', () {
      final json = {
        'id': '1',
        'title': 'Test Title',
        'summary': 'Test Summary',
        'paragraphs': ['p1', 'p2'],
        'imageUrl': 'http://image.url',
        'mins_to_read': 5,
        'author': {'id': 'a1', 'full_name': 'Author Name'},
        'date_published': '01/01/2023',
      };

      final article = ArticleEntity.fromJson(json);

      expect(article.id, '1');
      expect(article.title, 'Test Title');
      expect(article.summary, 'Test Summary');
      expect(article.paragraphs, ['p1', 'p2']);
      expect(article.imageUrl, 'http://image.url');
      expect(article.minsToRead, 5);
      expect(article.author, const AuthorEntity(id: 'a1', fullName: 'Author Name'));
      expect(article.datePublished, '01/01/2023');
      expect(article.isHovering, isFalse);
    });

    test('fromJson uses default author if author is null', () {
      final json = {
        'id': '1',
        'title': 'Test Title',
        'summary': 'Test Summary',
        'paragraphs': ['p1', 'p2'],
        'imageUrl': null,
        'mins_to_read': null,
        'author': null,
        'date_published': '01/01/2023',
      };

      final article = ArticleEntity.fromJson(json);

      expect(article.author, const AuthorEntity(id: '', fullName: 'Anonymous'));
    });

    test('copyWith returns a new instance with updated values', () {
      final original = const ArticleEntity(
        id: '1',
        title: 'Title',
        summary: 'Summary',
        paragraphs: ['p1'],
        author: AuthorEntity(id: 'a1', fullName: 'Author'),
        datePublished: '01/01/2023',
        minsToRead: 5,
        imageUrl: 'img',
        isHovering: false,
      );

      final copy = original.copyWith(title: 'New Title', minsToRead: 10, isHovering: true);

      expect(copy.id, '1');
      expect(copy.title, 'New Title');
      expect(copy.summary, 'Summary');
      expect(copy.paragraphs, ['p1']);
      expect(copy.author, const AuthorEntity(id: 'a1', fullName: 'Author'));
      expect(copy.datePublished, '01/01/2023');
      expect(copy.minsToRead, 10);
      expect(copy.imageUrl, 'img');
      expect(copy.isHovering, true);
    });

    test('copyWith returns identical instance if no arguments are provided', () {
      final original = const ArticleEntity(
        id: '1',
        title: 'Title',
        summary: 'Summary',
        paragraphs: ['p1'],
        author: AuthorEntity(id: 'a1', fullName: 'Author'),
        datePublished: '01/01/2023',
      );

      final copy = original.copyWith();

      expect(copy, isNot(same(original)));
      expect(copy.id, original.id);
      expect(copy.title, original.title);
      expect(copy.summary, original.summary);
      expect(copy.paragraphs, original.paragraphs);
      expect(copy.author, original.author);
      expect(copy.datePublished, original.datePublished);
      expect(copy.minsToRead, original.minsToRead);
      expect(copy.imageUrl, original.imageUrl);
      expect(copy.isHovering, original.isHovering);
    });
  });
}
