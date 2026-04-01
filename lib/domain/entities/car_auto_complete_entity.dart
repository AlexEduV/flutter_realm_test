class CarAutoCompleteEntity {
  final int manufacturerId;
  final String manufacturer;
  final List<String> models;

  CarAutoCompleteEntity({
    required this.manufacturerId,
    required this.manufacturer,
    required this.models,
  });

  factory CarAutoCompleteEntity.fromJson(Map<String, dynamic> json) {
    return CarAutoCompleteEntity(
      manufacturerId: json['id'] as int,
      manufacturer: json['name'] as String,
      models: json['models'] as List<String>,
    );
  }
}
