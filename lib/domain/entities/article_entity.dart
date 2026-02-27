class ArticleEntity {
  final String id;
  final String title;
  final String summary;
  final List<String> paragraphs;
  final String? imageUrl;

  const ArticleEntity({
    required this.id,
    required this.title,
    required this.summary,
    required this.paragraphs,
    this.imageUrl,
  });

  factory ArticleEntity.empty() {
    return const ArticleEntity(id: '', title: '', summary: '', paragraphs: []);
  }

  static ArticleEntity fromJson(Map<String, dynamic> json) {
    return ArticleEntity(
      id: json['id'] as String,
      title: json['title'] as String,
      summary: json['summary'] as String,
      paragraphs: List<String>.from(json['paragraphs'] as List),
      imageUrl: json['imageUrl'],
    );
  }
}
