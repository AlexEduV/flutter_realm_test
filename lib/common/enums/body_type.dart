import 'package:test_futter_project/common/enums/car_type.dart';

/// Types of vehicle body configurations.
enum BodyType {
  /// A standard sedan.
  sedan,

  /// A compact hatchback.
  hatchback,

  /// A universal body style.
  universal,

  /// A minivan.
  minivan,

  /// A coupe.
  coupe,

  /// A crossover.
  crossover,

  /// A semi-trailer.
  semi,

  /// A bike.
  bike,
}

const Map<CarType, List<BodyType>> carTypeToBodyTypes = {
  CarType.car: [
    BodyType.sedan,
    BodyType.hatchback,
    BodyType.universal,
    BodyType.minivan,
    BodyType.coupe,
    BodyType.crossover,
  ],
  CarType.truck: [BodyType.semi],
  CarType.bike: [BodyType.bike],
};
