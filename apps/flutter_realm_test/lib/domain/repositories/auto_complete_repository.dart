import '../../common/enums/car_type.dart';
import '../entities/car_auto_complete_entity.dart';

abstract interface class AutoCompleteRepository {
  Future<List<CarAutoCompleteEntity>> getAutoCompleteModelListByType(CarType type);
}
