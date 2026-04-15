import 'package:test_flutter_project/common/enums/car_type.dart';
import 'package:test_flutter_project/domain/data_sources/remote/auto_complete_remote_data_source.dart';
import 'package:test_flutter_project/domain/entities/car_auto_complete_entity.dart';
import 'package:test_flutter_project/domain/repositories/auto_complete_repository.dart';

class AutoCompleteRepositoryImpl implements AutoCompleteRepository {
  final AutoCompleteRemoteDataSource _autoCompleteRemoteDataSource;

  AutoCompleteRepositoryImpl(this._autoCompleteRemoteDataSource);

  @override
  Future<List<CarAutoCompleteEntity>> getAutoCompleteModelListByType(CarType type) {
    return _autoCompleteRemoteDataSource.getAutoCompleteModelListByType(type);
  }
}
