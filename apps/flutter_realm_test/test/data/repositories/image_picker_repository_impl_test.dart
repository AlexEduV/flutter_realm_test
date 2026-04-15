import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test_flutter_project/data/repositories/image_picker_repository_impl.dart';
import 'package:test_flutter_project/domain/data_sources/local/image_picker_local_data_source.dart';

import 'image_picker_repository_impl_test.mocks.dart';

@GenerateMocks([ImagePickerLocalDataSource])
void main() {
  late MockImagePickerLocalDataSource mockLocalDataSource;
  late ImagePickerRepositoryImpl repository;

  setUp(() {
    mockLocalDataSource = MockImagePickerLocalDataSource();
    repository = ImagePickerRepositoryImpl(mockLocalDataSource);
  });

  test('pickImage calls local data source and returns image path', () async {
    when(mockLocalDataSource.pickImage()).thenAnswer((_) async => '/images/photo.jpg');

    final result = await repository.pickImage();

    expect(result, '/images/photo.jpg');
    verify(mockLocalDataSource.pickImage()).called(1);
    verifyNoMoreInteractions(mockLocalDataSource);
  });

  test('pickImage returns null when local data source returns null', () async {
    when(mockLocalDataSource.pickImage()).thenAnswer((_) async => null);

    final result = await repository.pickImage();

    expect(result, isNull);
    verify(mockLocalDataSource.pickImage()).called(1);
    verifyNoMoreInteractions(mockLocalDataSource);
  });
}
