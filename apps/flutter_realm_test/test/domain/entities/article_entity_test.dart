import 'package:flutter_test/flutter_test.dart';
import 'package:test_flutter_project/domain/entities/article_entity.dart';
import 'package:test_flutter_project/domain/entities/author_entity.dart';

void main() {
  group('ArticleEntity', () {
    final author = const AuthorEntity(id: 'a1', fullName: 'Author Name');
    final paragraphs = ['Para 1', 'Para 2'];

    test('constructor and properties', () {
      final article = ArticleEntity(
        id: 'id1',
        title: 'Title',
        summary: 'Summary',
        paragraphs: paragraphs,
        author: author,
        datePublished: '2023-01-01',
        minsToRead: 5,
        imageUrl: 'http://img.com/img.png',
        isHovering: true,
      );
      expect(article.id, 'id1');
      expect(article.title, 'Title');
      expect(article.summary, 'Summary');
      expect(article.paragraphs, paragraphs);
      expect(article.author, author);
      expect(article.datePublished, '2023-01-01');
      expect(article.minsToRead, 5);
      expect(article.imageUrl, 'http://img.com/img.png');
      expect(article.isHovering, true);
    });

    test('empty factory', () {
      final empty = ArticleEntity.empty();
      expect(empty.id, '');
      expect(empty.title, '');
      expect(empty.summary, '');
      expect(empty.paragraphs, []);
      expect(empty.author, const AuthorEntity(id: 'testId', fullName: 'Test Author'));
      expect(empty.datePublished, '20/11/2022');
      expect(empty.minsToRead, isNull);
      expect(empty.imageUrl, isNull);
      expect(empty.isHovering, false);
    });

    test('fromJson with all fields', () {
      final json = {
        'id': 'id2',
        'title': 'Title2',
        'summary': 'Summary2',
        'paragraphs': ['P1', 'P2'],
        'imageUrl': 'http://img.com/2.png',
        'mins_to_read': 10,
        'author': {'id': 'a2', 'full_name': 'Author 2'},
        'date_published': '2023-02-02',
      };
      final article = ArticleEntity.fromJson(json);
      expect(article.id, 'id2');
      expect(article.title, 'Title2');
      expect(article.summary, 'Summary2');
      expect(article.paragraphs, ['P1', 'P2']);
      expect(article.imageUrl, 'http://img.com/2.png');
      expect(article.minsToRead, 10);
      expect(article.author, const AuthorEntity(id: 'a2', fullName: 'Author 2'));
      expect(article.datePublished, '2023-02-02');
    });

    test('fromJson with missing optional fields', () {
      final json = {
        'id': 'id3',
        'title': 'Title3',
        'summary': 'Summary3',
        'paragraphs': [],
        'author': null,
        'date_published': '2023-03-03',
      };
      final article = ArticleEntity.fromJson(json);
      expect(article.id, 'id3');
      expect(article.title, 'Title3');
      expect(article.summary, 'Summary3');
      expect(article.paragraphs, []);
      expect(article.imageUrl, isNull);
      expect(article.minsToRead, isNull);
      expect(article.author, const AuthorEntity(id: '', fullName: 'Anonymous'));
      expect(article.datePublished, '2023-03-03');
    });

    test('copyWith returns updated values', () {
      final article = ArticleEntity(
        id: 'id1',
        title: 'Title',
        summary: 'Summary',
        paragraphs: paragraphs,
        author: author,
        datePublished: '2023-01-01',
      );
      final copy = article.copyWith(
        id: 'id2',
        title: 'New Title',
        minsToRead: 15,
        imageUrl: 'http://img.com/new.png',
        isHovering: true,
      );
      expect(copy.id, 'id2');
      expect(copy.title, 'New Title');
      expect(copy.summary, 'Summary');
      expect(copy.paragraphs, paragraphs);
      expect(copy.author, author);
      expect(copy.datePublished, '2023-01-01');
      expect(copy.minsToRead, 15);
      expect(copy.imageUrl, 'http://img.com/new.png');
      expect(copy.isHovering, true);
    });

    test('== and hashCode', () {
      final article1 = ArticleEntity(
        id: 'id1',
        title: 'Title',
        summary: 'Summary',
        paragraphs: paragraphs,
        author: author,
        datePublished: '2023-01-01',
      );
      final article2 = ArticleEntity(
        id: 'id1',
        title: 'Title',
        summary: 'Summary',
        paragraphs: paragraphs,
        author: author,
        datePublished: '2023-01-01',
      );
      final article3 = ArticleEntity(
        id: 'id3',
        title: 'Other',
        summary: 'Other',
        paragraphs: [],
        author: author,
        datePublished: '2023-01-01',
      );
      expect(article1, article2);
      expect(article1.hashCode, article2.hashCode);
      expect(article1 == article3, false);
    });
  });
}
