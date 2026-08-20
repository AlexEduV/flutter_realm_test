import '../../../data/dto/car_dto.dart';

abstract interface class CarRemoteDataSource {
  Future<List<CarDto>> fetchCars();

  Stream<List<CarDto>> get carStream;

  void dispose();
}
