class SentImageMetaDataModel {
  final String url;
  final double width;
  final double height;

  SentImageMetaDataModel({required this.url, required this.width, required this.height});

  factory SentImageMetaDataModel.fromJson(Map<String, dynamic> json) {
    return SentImageMetaDataModel(
      url: json['url'] ?? '',
      width: double.tryParse(json['width']) ?? 0.0,
      height: double.tryParse(json['height']) ?? 0.0,
    );
  }

  double getImageFactor() {
    if (width == 0) return 1.0;

    return height / width;
  }
}
