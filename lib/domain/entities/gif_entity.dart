import 'package:test_futter_project/data/dto/klipy_gif_dto.dart';

class GifEntity {
  final String id;
  final String title;
  final String previewImageUrl;
  final String imageUrl;
  final double width;
  final double height;

  GifEntity({
    required this.id,
    required this.title,
    required this.previewImageUrl,
    required this.imageUrl,
    required this.height,
    required this.width,
  });

  factory GifEntity.fromDto(KlipyGifDto dto) {
    return GifEntity(
      id: dto.id,
      title: dto.title,
      previewImageUrl: dto.previewImageUrl,
      imageUrl: dto.imageUrl,
      height: dto.height,
      width: dto.width,
    );
  }
}
