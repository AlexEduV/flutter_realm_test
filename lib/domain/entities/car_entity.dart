import '../../data/dto/car_dto.dart';
import '../../data/models/scheme.dart';

class CarEntity {
  final String carId;
  final String model;
  final String manufacturer;
  final String type;
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
    required this.type,
    this.year,
    this.owner,
    this.kilometers,
    this.distanceTo,
    this.price,
  });

  factory CarEntity.empty() {
    return CarEntity(
      carId: 'testId',
      model: 'Test Model',
      type: 'Car',
      manufacturer: 'Test Motors',
      isVerified: true,
      isHotPromotion: false,
    );
  }

  factory CarEntity.fromDto(CarDto dto) {
    return CarEntity(
      carId: dto.carId,
      model: dto.model,
      manufacturer: dto.manufacturer,
      isVerified: dto.isVerified,
      isHotPromotion: dto.isHotPromotion,
      type: dto.type,
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
      type: car.type,
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
