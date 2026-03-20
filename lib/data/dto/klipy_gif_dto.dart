class KlipyGifDto {
  final String id;
  final String title;
  final String previewImageUrl;
  final String imageUrl;
  final double width;
  final double height;

  KlipyGifDto({
    required this.id,
    required this.title,
    required this.previewImageUrl,
    required this.imageUrl,
    required this.height,
    required this.width,
  });

  factory KlipyGifDto.fromJson(Map<String, dynamic> json) {
    // KLIPY puts media inside 'media_formats'
    final media = json['media_formats']['tinygif'];

    return KlipyGifDto(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      imageUrl: json['media_formats']['gif']['url'],
      previewImageUrl: media['url'],
      width: (media['dims'][0] as num).toDouble(),
      height: (media['dims'][1] as num).toDouble(),
    );
  }
}
