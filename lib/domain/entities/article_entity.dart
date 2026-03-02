class ArticleEntity {
  final String id;
  final String title;
  final String authorFullName;
  final String datePublished;
  final int? minsToRead;
  final String summary;
  final List<String> paragraphs;
  final String? imageUrl;

  const ArticleEntity({
    required this.id,
    required this.title,
    required this.summary,
    required this.paragraphs,
    required this.authorFullName,
    required this.datePublished,
    this.minsToRead,
    this.imageUrl,
  });

  factory ArticleEntity.empty() {
    return const ArticleEntity(
      id: '',
      title: '',
      summary: '',
      paragraphs: [],
      authorFullName: 'Anonymous',
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
      authorFullName: json['author'] ?? 'Anonymous',
      datePublished: json['date_published'] as String,
    );
  }
}
