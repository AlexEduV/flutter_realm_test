import '../../data/dto/car_dto.dart';
import '../../data/models/scheme.dart';

class CarEntity {
  final String carId;
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

  factory CarEntity.fromSchema(Car car) {
    return CarEntity(
      carId: car.carId,
      model: car.model ?? '',
      manufacturer: car.manufacturer,
      isVerified: car.isChecked ?? false,
      isHotPromotion: car.isHotProposition ?? false,
      price: car.price,
      distanceTo: car.distanceTo,
      year: car.year,
      owner: car.owner?.name ?? '',
      kilometers: car.kilometers,
    );
  }
}
