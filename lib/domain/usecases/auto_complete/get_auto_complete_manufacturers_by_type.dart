import 'package:test_futter_project/domain/entities/car_auto_complete_entity.dart';
import 'package:test_futter_project/domain/repositories/auto_complete_repository.dart';
import 'package:test_futter_project/domain/usecases/usecase.dart';

import '../../../common/enums/car_type.dart';

class GetAutoCompleteManufacturersByType
    implements UseCaseWithParams<CarType, Future<List<CarAutoCompleteEntity>>> {
  GetAutoCompleteManufacturersByType(this._autoCompleteRepository);

  final AutoCompleteRepository _autoCompleteRepository;

  @override
  Future<List<CarAutoCompleteEntity>> call(CarType params) {
    return _autoCompleteRepository.getAutoCompleteModelListByType(params);
  }
}
