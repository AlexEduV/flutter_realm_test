import '../../../common/enums/car_type.dart';
import '../../entities/car_auto_complete_entity.dart';

abstract class AutoCompleteRemoteDataSource {
  Future<List<CarAutoCompleteEntity>> getAutoCompleteModelListByType(CarType type);
}
