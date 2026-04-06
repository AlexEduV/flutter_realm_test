import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test_futter_project/common/enums/car_type.dart';
import 'package:test_futter_project/data/data_sources/remote/mock_auto_complete_remote_data_source_impl.dart';
import 'package:test_futter_project/data/repositories/auto_complete_repository_impl.dart';
import 'package:test_futter_project/domain/entities/car_auto_complete_entity.dart';

import 'auto_complete_repository_impl_test.mocks.dart';

@GenerateMocks([MockAutoCompleteRemoteDataSource])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockMockAutoCompleteRemoteDataSource mockRemoteDataSource;
  late AutoCompleteRepositoryImpl repository;

  setUp(() {
    mockRemoteDataSource = MockMockAutoCompleteRemoteDataSource();
    repository = AutoCompleteRepositoryImpl(mockRemoteDataSource);
  });

  test(
    'getAutoCompleteModelListByType delegates to remote data source and returns result',
    () async {
      // Arrange
      final carType = CarType.car;
      final expectedList = [
        CarAutoCompleteEntity(
          manufacturerId: 1,
          manufacturer: 'Toyota',
          models: ['Corolla', 'Camry'],
        ),
        CarAutoCompleteEntity(
          manufacturerId: 2,
          manufacturer: 'Honda',
          models: ['Civic', 'Accord'],
        ),
      ];
      when(
        mockRemoteDataSource.getAutoCompleteModelListByType(carType),
      ).thenAnswer((_) async => expectedList);

      // Act
      final result = await repository.getAutoCompleteModelListByType(carType);

      // Assert
      expect(result, expectedList);
      verify(mockRemoteDataSource.getAutoCompleteModelListByType(carType)).called(1);
      verifyNoMoreInteractions(mockRemoteDataSource);
    },
  );
}
