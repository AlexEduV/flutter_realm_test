class KlipyGifDto {
  KlipyGifDto({
    required this.id,
    required this.title,
    required this.previewImageUrl,
    required this.imageUrl,
    required this.height,
    required this.width,
  });

  factory KlipyGifDto.fromV1Json(Map<String, dynamic> json) {
    final media = json['file']['sm']['gif'];
    final previewMedia = json['file']['xs']['gif'];

    return KlipyGifDto(
      id: (json['id'] ?? 0).toString(),
      title: json['title'] ?? '',
      imageUrl: media['url'],
      previewImageUrl: previewMedia['url'],
      width: (media['width'] as num).toDouble(),
      height: (media['height'] as num).toDouble(),
    );
  }

  final String id;
  final String title;
  final String previewImageUrl;
  final String imageUrl;
  final double width;
  final double height;
}
