class CarDto {
  final int carId;
  final String model;
  final String manufacturer;
  final String? year;
  final String? owner;
  final bool isVerified;
  final bool isHotPromotion;
  int? kilometers = 0;
  int? distanceTo;
  int? price = 0;

  CarDto({
    required this.carId,
    required this.model,
    required this.manufacturer,
    required this.isVerified,
    required this.isHotPromotion,
    this.year,
    this.owner,
    this.kilometers,
    this.distanceTo,
    this.price,
  });

  factory CarDto.fromJson(Map<String, dynamic> json) => CarDto(
    carId: json['id'] as int,
    model: json['model'] as String,
    manufacturer: json['manufacturer'] as String,
    year: json['year'] as String?,
    isVerified: json['is_verified'] as bool,
    price: json['price'] as int?,
    isHotPromotion: json['is_hot_promotion'] as bool,
  );
}
