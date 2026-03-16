import 'package:test_futter_project/domain/entities/author_entity.dart';

class ArticleEntity {
  final String id;
  final String title;
  final AuthorEntity author;
  final String datePublished;
  final int? minsToRead;
  final String summary;
  final List<String> paragraphs;
  final String? imageUrl;
  final bool isHovering;

  const ArticleEntity({
    required this.id,
    required this.title,
    required this.summary,
    required this.paragraphs,
    required this.author,
    required this.datePublished,
    this.minsToRead,
    this.imageUrl,
    this.isHovering = false,
  });

  factory ArticleEntity.empty() {
    return const ArticleEntity(
      id: '',
      title: '',
      summary: '',
      paragraphs: [],
      author: AuthorEntity(id: 'testId', fullName: 'Test Author'),
      datePublished: '20/11/2022',
    );
  }

  static ArticleEntity fromJson(Map<String, dynamic> json) {
    return ArticleEntity(
      id: json['id'] as String,
      title: json['title'] as String,
      summary: json['summary'] as String,
      paragraphs: List<String>.from(json['paragraphs'] as List),
      imageUrl: json['imageUrl'] as String?,
      minsToRead: json['mins_to_read'] as int?,
      author: json['author'] != null
          ? AuthorEntity.fromJson(json['author'])
          : const AuthorEntity(id: '', fullName: 'Anonymous'),
      datePublished: json['date_published'] as String,
    );
  }

  ArticleEntity copyWith({
    String? id,
    String? title,
    AuthorEntity? author,
    String? datePublished,
    int? minsToRead,
    String? summary,
    List<String>? paragraphs,
    String? imageUrl,
    bool? isHovering,
  }) {
    return ArticleEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      summary: summary ?? this.summary,
      paragraphs: paragraphs ?? this.paragraphs,
      author: author ?? this.author,
      datePublished: datePublished ?? this.datePublished,
      minsToRead: minsToRead ?? this.minsToRead,
      imageUrl: imageUrl ?? this.imageUrl,
      isHovering: isHovering ?? this.isHovering,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    return other is ArticleEntity &&
        other.id == id &&
        other.title == title &&
        other.summary == summary &&
        other.paragraphs == paragraphs &&
        other.author == author &&
        other.datePublished == datePublished &&
        other.minsToRead == minsToRead &&
        other.imageUrl == imageUrl &&
        other.isHovering == isHovering;
  }

  @override
  int get hashCode => Object.hash(
    id,
    title,
    summary,
    Object.hashAll(paragraphs),
    author,
    datePublished,
    minsToRead,
    imageUrl,
    isHovering,
  );
}
