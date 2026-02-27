class ArticleEntity {
  final String id;
  final String title;
  final String? imageSrc;

  const ArticleEntity({required this.id, required this.title, required this.imageSrc});

  factory ArticleEntity.empty() {
    return const ArticleEntity(id: '', title: '', imageSrc: '');
  }
}
