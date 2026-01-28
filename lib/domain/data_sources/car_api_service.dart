import '../../data/dto/car_dto.dart';

abstract class CarApiService {
  Future<List<CarDto>> fetchCars();

  Stream<List<CarDto>> get carStream;

  void dispose();
}
