import '../../data/dto/car_dto.dart';

class CarEntity {
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

  CarEntity({
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

  factory CarEntity.fromDto(CarDto dto) {
    return CarEntity(
      carId: dto.carId,
      model: dto.model,
      manufacturer: dto.manufacturer,
      isVerified: dto.isVerified,
      isHotPromotion: dto.isHotPromotion,
      price: dto.price,
      distanceTo: dto.distanceTo,
      year: dto.year,
      owner: dto.owner,
      kilometers: dto.kilometers,
    );
  }
}
