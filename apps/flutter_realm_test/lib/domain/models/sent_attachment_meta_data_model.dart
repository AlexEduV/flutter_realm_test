class SentAttachmentMetaDataModel {
  final String name;
  final String? path;
  final int size;

  SentAttachmentMetaDataModel({required this.name, required this.size, this.path});

  factory SentAttachmentMetaDataModel.fromJson(Map<String, dynamic> json) {
    return SentAttachmentMetaDataModel(
      name: json['name'] ?? '',
      path: json['path'],
      size: json['size'] ?? 0,
    );
  }
}
