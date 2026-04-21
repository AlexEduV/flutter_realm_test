class CarAutoCompleteEntity {
  final int manufacturerId;
  final String manufacturer;
  final List<String> models;
  final String? imageSrc;

  CarAutoCompleteEntity({
    required this.manufacturerId,
    required this.manufacturer,
    required this.models,
    this.imageSrc,
  });

  factory CarAutoCompleteEntity.fromJson(Map<String, dynamic> json) {
    return CarAutoCompleteEntity(
      manufacturerId: json['id'] as int,
      manufacturer: json['name'] as String,
      models: (json['models'] as List<dynamic>).map((e) => e as String).toList(),
      imageSrc: json['icon'] as String?,
    );
  }
}
