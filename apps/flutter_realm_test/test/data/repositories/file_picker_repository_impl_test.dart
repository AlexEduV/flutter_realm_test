import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test_futter_project/data/repositories/file_picker_repository_impl.dart';
import 'package:test_futter_project/domain/data_sources/local/file_picker_local_data_source.dart';
import 'package:test_futter_project/domain/entities/attachment_entity.dart';

import 'file_picker_repository_impl_test.mocks.dart';

@GenerateMocks([FilePickerLocalDataSource])
void main() {
  late MockFilePickerLocalDataSource mockLocalDataSource;
  late FilePickerRepositoryImpl repository;

  setUp(() {
    mockLocalDataSource = MockFilePickerLocalDataSource();
    repository = FilePickerRepositoryImpl(mockLocalDataSource);
  });

  test('pickFile calls local data source and returns attachment', () async {
    final attachment = AttachmentEntity(name: 'file.txt', size: 1234, path: '/some/path/file.txt');
    when(mockLocalDataSource.pickFile()).thenAnswer((_) async => attachment);

    final result = await repository.pickFile();

    expect(result, attachment);
    verify(mockLocalDataSource.pickFile()).called(1);
    verifyNoMoreInteractions(mockLocalDataSource);
  });

  test('pickFile returns null when local data source returns null', () async {
    when(mockLocalDataSource.pickFile()).thenAnswer((_) async => null);

    final result = await repository.pickFile();

    expect(result, isNull);
    verify(mockLocalDataSource.pickFile()).called(1);
    verifyNoMoreInteractions(mockLocalDataSource);
  });
}
