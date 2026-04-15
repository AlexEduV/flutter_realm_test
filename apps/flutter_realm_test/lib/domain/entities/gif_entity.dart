import 'dart:convert';

import 'package:test_flutter_project/data/dto/klipy_gif_dto.dart';

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

  String toPayload() {
    return jsonEncode({'url': imageUrl, 'width': width.toString(), 'height': height.toString()});
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GifEntity &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          title == other.title &&
          previewImageUrl == other.previewImageUrl &&
          imageUrl == other.imageUrl &&
          width == other.width &&
          height == other.height;

  @override
  int get hashCode =>
      id.hashCode ^
      title.hashCode ^
      previewImageUrl.hashCode ^
      imageUrl.hashCode ^
      width.hashCode ^
      height.hashCode;
}
